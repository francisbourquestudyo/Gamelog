//
//  GameState.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation

enum GameState: String, Codable {
    case notStarted = "not_started"
    case currentlyPlaying = "currently_playing"
    case onPause = "on_pause"
    case finished
    case abandonned
}
