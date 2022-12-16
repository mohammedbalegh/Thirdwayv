//
//  UserDefaultsError.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 16/12/2022.
//

import Foundation

enum UserDefaultsError: Error {
    case failedToDecode
    case couldNotRetrieve
}

extension UserDefaultsError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedToDecode:  return "Failed to decode userDefaults"
        case .couldNotRetrieve: return "No data found associated with this key"
        }
    }
}
