import Fluent
import Vapor

func routes(_ app: Application) throws {
    app.get { req in
        return "It works!"
    }

    let apiRoutes = app.grouped("api")
    try apiRoutes.register(collection: UsersController())

    let tokenProtected = apiRoutes.grouped(UserToken.authenticator())
    tokenProtected.get("me") { req -> User in
        try req.auth.require(User.self)
    }

    try tokenProtected.register(collection: GamesController())
}
