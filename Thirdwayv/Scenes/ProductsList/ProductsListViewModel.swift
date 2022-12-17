//  
//  ProductsListViewModel.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation

// MARK: ProductsListViewModel

class ProductsListViewModel: ProductsListViewModelType {
    var selectedProduct: Product?
    var getProducts: ProductsCall
    var products: Observable<[Product]> = Observable([])
    var error: Observable<String> = Observable("")

    init(getProducts: ProductsCall) {
        self.getProducts = getProducts
    }

    func loadProducts() {
        getProducts.loadData { [weak self] result in
            switch result {
            case .success(let products):
                self?.products.value.append(contentsOf: products)
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
}
