//
//  ProductsCall.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation
import Network

protocol ProductsCall {
    func loadData(completion: @escaping ((Result<[Product], Error>) -> Void))
}

class ProductsList: ProductsCall {

    var networkCheck = NetworkMonitor.shared

    func loadData(completion: @escaping ((Result<[Product], Error>) -> Void)) {
        APIManager().fetchData(request: ProductsRequest.products,
                               model: [Product].self) { result in
            switch result {
            case .success(let products):
                self.networkCheck.isConnected.remove(observer: self)
                completion(.success(products))
                // TODO: Cache Products
            case .failure(let error):
                if let error = error as? NetworkingError {
                    switch error {
                    case .noInternetConnection:
                        self.networkCheck.isConnected.observe(on: self) { [weak self] connection in
                            guard let isConnected = connection,
                                  isConnected == true else { return }
                            self?.loadData(completion: completion)
                        }
                    default:
                        break
                    }
                }
                completion(.failure(error))
                // TODO: Get cached products
            }
        }
    }
}
