//  
//  ProductsListViewModelType.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation

/// ProductsList Input & Output
///
typealias ProductsListViewModelType = ProductsListViewModelInput & ProductsListViewModelOutput

/// ProductsList ViewModel Input
///
protocol ProductsListViewModelInput {
    var getProducts: ProductsCall { get } 
    func loadProducts()
    func selectedIndex(_ indexPath: IndexPath)
}

/// ProductsList ViewModel Output
///
protocol ProductsListViewModelOutput {
    var items: Observable<[Product]> { get }
    var error: Observable<String> { get }
    var selectedProduct: Product? { get }
}
