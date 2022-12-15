//
//  NetworkingError.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 14/12/2022.
//

import Foundation

public enum NetworkingError: Error {
    case noInternetConnection
    case badRequest
    case custom(message: String)
    case encodingFailed
    case invalidURL
    case invalidServerResponse
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noInternetConnection:           return "No Internet Connection"
            case .badRequest:        return "invalid Request"
            case .custom(let message): return message
            case .invalidServerResponse:          return "Internal Server response"
            case .invalidURL:                return "invalid url"
            case .encodingFailed:       return "failed to encode"
        }
    }
}
