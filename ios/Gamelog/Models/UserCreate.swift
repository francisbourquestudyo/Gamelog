//
//  UserCreate.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation

struct UserCreate: Codable {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
}
