//
//  GameMigration.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation
import Fluent

extension Game {
    struct Migration: Fluent.Migration {
        var name: String { "CreateGame" }

        func prepare(on database: Database) -> EventLoopFuture<Void> {
            database.schema("games")
                .id()
                .field("title", .string, .required)
                .field("description", .string, .required)
                .field("platform", .string, .required)
                .field("rating", .int)
                .field("state", .string, .required)
                .field("user_id", .uuid, .required, .references("users", "id"))
                .create()
        }

        func revert(on database: Database) -> EventLoopFuture<Void> {
            database.schema("games").delete()
        }
    }
}
