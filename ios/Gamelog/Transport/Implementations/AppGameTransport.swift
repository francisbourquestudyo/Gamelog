//
//  AppGameTransport.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation
import Alamofire

final class AppGameTransport: GameTransport {
    let baseURL = "http://192.168.50.134:8080/api/games"

    func getGames() -> [Game] {
//        let headers = [
//           "Authorization" : String(format: "Bearer: @%", token)
//        ]
//        AF.request(baseURL).re
        return []
    }
}
