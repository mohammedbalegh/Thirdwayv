//
//  RequestProtocol.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 14/12/2022.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var path: String { get }
    var headers: [String: String] { get }
    var params: [String: Any] { get }
    var urlParams: [String: String?] { get }
    var addAuthorizationToken: Bool { get }
    var requestType: RequestType { get }
}

extension RequestProtocol {

    var url: String {
        NetworkingConstants.baseURL
    }

    var addAuthorizationToken: Bool {
        true
    }

    var params: [String: Any] {
        [:]
    }

    var urlParams: [String: String?] {
        [:]
    }

    var headers: [String: String] {
        [:]
    }

    func createURLRequest() throws -> URLRequest {

        var components = URLComponents()
        components.host = url
        components.path = path

        let urlPath = url + path
        if !urlParams.isEmpty {
            components.queryItems = urlParams.map {
                URLQueryItem(name: $0, value: $1)
            }
        }

        guard let url = URL(string: urlPath)
        else { throw NetworkingError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue

        if !headers.isEmpty {
            urlRequest.allHTTPHeaderFields = headers
        }

        urlRequest.setValue("application/json",
                            forHTTPHeaderField: "Content-Type")

        if !params.isEmpty {
            urlRequest.httpBody = try JSONSerialization.data(
                withJSONObject: params)
        }

        return urlRequest
    }
}
