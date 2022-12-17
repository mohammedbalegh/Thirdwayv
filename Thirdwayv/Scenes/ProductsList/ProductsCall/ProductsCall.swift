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
                UserDefaultsManager.shared.save(model: products, key: Keys.product)
                completion(.success(products))
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
                switch UserDefaultsManager.shared.retrieve(key: Keys.product) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
                completion(.failure(error))
            }
        }
    }
}
