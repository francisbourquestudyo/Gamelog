//
//  Platform.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation

enum Platform: String, Codable {
    case xbox360 = "xbox_360"
    case xboxOne = "xbox_one"
    case playstation3 = "playstation_3"
    case playstation4 = "playstation_4"
    case nintendoSwitch = "nintendo_switch"
    case nintendo3DS = "nintendo_3ds"
    case pc
    case mobile
    case stadia
}
