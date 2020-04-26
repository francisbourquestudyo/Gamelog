//
//  GameTransport.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation
import Alamofire

protocol GameTransport {
    func getGames() -> [Game]
}
