//
//  UsersController.swift
//  
//
//  Created by Francis Bourque on 2020-04-25.
//

import Foundation
import Vapor

final class UsersController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let router = routes.grouped("users")

        router.post("signup", use: signUp(_:))

        // Password protected
        let passwordProtected = router.grouped(User.authenticator())
        passwordProtected.post("login", use: login(_:))
        passwordProtected.get("logout", use: logout(_:))
    }

    func signUp(_ req: Request) throws -> EventLoopFuture<UserInfo> {
        try User.Create.validate(req)
        let create = try req.content.decode(User.Create.self)
        guard create.password == create.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            username: create.username,
            email: create.email,
            passwordHash: Bcrypt.hash(create.password)
        )

        let userSave = user.save(on: req.db).map{ user }
        let tokenSave = userSave.flatMap { user -> EventLoopFuture<UserToken> in
            let token: UserToken
            do {
                token = try user.generateToken()
            } catch {
                return req.eventLoop.makeFailedFuture(error)
            }

            return token.save(on: req.db).map { token }
        }

        return tokenSave.flatMap { token -> EventLoopFuture<UserInfo> in
            do {
                let userId = try user.requireID()
                return req.eventLoop.makeSucceededFuture(UserInfo(
                    id: userId,
                    username: user.username,
                    email: user.email,
                    token: token.value))
            } catch {
                return req.eventLoop.makeFailedFuture(error)
            }
        }
    }

    func login(_ req: Request) throws -> EventLoopFuture<UserInfo> {
        let user = try req.auth.require(User.self)
        let userId = try user.requireID()
        let token = try user.generateToken()
        return token.save(on: req.db).map {
            UserInfo(
                id: userId,
                username:
                user.username,
                email: user.email,
                token: token.value)
        }
    }

    func logout(_ req: Request) throws -> HTTPResponseStatus {
        req.auth.logout(User.self)
        return HTTPResponseStatus.ok
    }
}
