//
//  APIManager.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 14/12/2022.
//

import Foundation

protocol APIManagerProtocol {
    func fetchData<T: Decodable>(request: RequestProtocol, model: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void)
}

class APIManager: APIManagerProtocol {

    private let urlSession: URLSession

    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }

    func fetchData<T: Decodable>(request: RequestProtocol,
                                 model: T.Type,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let urlRequest = try request.createURLRequest()
            URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let _ = error {
                    completion(.failure(NetworkingError.noInternetConnection))
                }else {
                    guard let data = data else {
                        completion(.failure(NetworkingError.invalidServerResponse))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let responseModel = try decoder.decode(T.self, from: data)
                        completion(.success(responseModel))
                    }catch {
                        completion(.failure(NetworkingError.custom(message: error.localizedDescription)))
                    }
                }
            }.resume()
        } catch {
            completion(.failure(NetworkingError.custom(message: error.localizedDescription)))
        }
    }
}
