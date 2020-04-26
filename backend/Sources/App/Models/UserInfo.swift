//
//  UserInfo.swift
//  
//
//  Created by Francis Bourque on 2020-04-26.
//

import Foundation
import Vapor

final class UserInfo: Content {
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
