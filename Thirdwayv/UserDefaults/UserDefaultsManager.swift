//
//  UserDefaultsManager.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 16/12/2022.
//

import Foundation

class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    let userDefaults = UserDefaults.standard

    func save(model: [Product], key: Keys) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(model)
            userDefaults.set(data, forKey: key.rawValue)
        } catch {
            print(error)
        }
    }

    func retrieve(key: Keys) -> Result<[Product], Error> {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            do {
                let decoder = JSONDecoder()
                let products = try decoder.decode([Product].self, from: data)
                return .success(products)
            } catch {
                return .failure(UserDefaultsError.failedToDecode)
            }
        }else {
            return .failure(UserDefaultsError.couldNotRetrieve)
        }
    }
}
