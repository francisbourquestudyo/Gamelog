//
//  Game.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation

final class Game: Codable {
    var id: UUID?
    var title: String
    var description: String
    var platform: Platform
    var rating: Int?
    var state: GameState

    init(
        title: String,
        description: String,
        platform: Platform,
        rating: Int?,
        state: GameState
    ) {
        self.title = title
        self.description = description
        self.platform = platform
        self.rating = rating
        self.state = state
    }
}
