//
//  AppUserTransport.swift
//  Gamelog
//
//  Created by Francis Bourque on 2020-04-26.
//  Copyright © 2020 Francis Bourque. All rights reserved.
//

import Foundation
import Alamofire

final class AppUserTransport: UserTransport {
    let baseURL = "http://192.168.50.134:8080/api/users"
    let userInfoKey = "UserInfo"

    func getUser() -> UserInfo? {
        let defaults = UserDefaults.standard

        if let userData = defaults.object(forKey: userInfoKey) as? Data {
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(UserInfo.self, from: userData) {
                return user
            }
        }

        return nil
    }

    func signUp(user: UserCreate, _ completion: @escaping (Result<UserInfo, Error>) -> Void) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(user)

        var request = URLRequest(url: URL(string: "\(baseURL)/signup")!)
        request.httpMethod = HTTPMethod.put.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        AF.request(request).response { [weak self] response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                let decoder = JSONDecoder()
                if let data = response.data, let user = try? decoder.decode(UserInfo.self, from: data) {
                    self?.setUser(user)
                    completion(.success(user))
                } else {
                    let error = NSError()
                    completion(.failure(error))
                }
            }
        }
    }

    func login(username: String, password: String, _ completion: @escaping (Result<UserInfo, Error>) -> Void) {
        AF.request("\(baseURL)/login").response { [weak self] response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                let decoder = JSONDecoder()
                if let data = response.data, let user = try? decoder.decode(UserInfo.self, from: data) {
                    self?.setUser(user)
                    completion(.success(user))
                } else {
                    let error = NSError()
                    completion(.failure(error))
                }
            }
        }
    }

    func logout(_ completion: @escaping (Result<Void, Error>) -> Void) {
        AF.request("\(baseURL)/logout").response { [weak self] response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                self?.resetUser()
                completion(.success(()))
            }
        }
    }

    private func setUser(_ user: UserInfo) {
        let defaults = UserDefaults.standard
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            defaults.set(encoded, forKey: userInfoKey)
        }
    }

    private func resetUser() {
        UserDefaults.standard.removeObject(forKey: userInfoKey)
    }
}
