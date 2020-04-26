//
//  GamesController.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation
import Vapor

final class GamesController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let router = routes.grouped("games")
        router.post(use: create(_:))
        router.get(use: getAll(_:))
    }

    func create(_ req: Request) throws -> EventLoopFuture<Game> {
        let user = try req.auth.require(User.self)
        let userId = try user.requireID()
        let create = try req.content.decode(Game.Create.self)

        let game = Game(
            title: create.title,
            description: create.description,
            platform: create.platform,
            rating: nil,
            state: .notStarted,
            userID: userId)

        return game.save(on: req.db)
            .map { game }
    }

    func getAll(_ req: Request) throws -> EventLoopFuture<[Game]> {
        let user = try req.auth.require(User.self)
        let userId = try user.requireID()
        return Game.query(on: req.db).with(\.$user).all().map { games -> [Game] in
            return games.filter { $0.user.id == userId }
        }
    }
}
