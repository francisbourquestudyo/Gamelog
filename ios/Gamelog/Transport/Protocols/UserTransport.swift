//
//  UserTransport.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation

protocol UserTransport {
    func getUser() -> UserInfo?
    func signUp(user: UserCreate, _ completion: @escaping (Result<UserInfo, Error>) -> Void)
    func login(username: String, password: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void)
    func logout(_ completion: @escaping (_ response: Result<Void, Error>) -> Void)
}
