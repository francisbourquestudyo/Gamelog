//
//  Game.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation
import Fluent
import Vapor

final class Game: Model, Content {
    static let schema = "games"

    // ----------------------------------------------------------------------------------------
    // MARK: Fields

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String
    
    @Field(key: "platform")
    var platform: Platform

    @Field(key: "rating")
    var rating: Int?

    @Field(key: "state")
    var state: GameState

    // ----------------------------------------------------------------------------------------
    // MARK: Relationships

    @Parent(key: "user_id")
    var user: User

    // ----------------------------------------------------------------------------------------
    // MARK: Initializers

    init() {}

    init(
        title: String,
        description: String,
        platform: Platform,
        rating: Int?,
        state: GameState,
        userID: User.IDValue
    ) {
        self.title = title
        self.description = description
        self.platform = platform
        self.rating = rating
        self.state = state
        self.$user.id = userID
    }
}

extension Game {
    struct Create: Content {
        var title: String
        var description: String
        var platform: Platform
    }
}
