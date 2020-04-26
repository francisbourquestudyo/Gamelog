//
//  User.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation

final class UserInfo: Codable {
    let id: UUID
    let username: String
    let email: String
    let token: String

    init(id: UUID, username: String, email: String, token: String) {
        self.id = id
        self.username = username
        self.email = email
        self.token = token
    }
}
