//
//  Product.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation

struct Product: Decodable {
    let id: Int
    let productDescription: String
    let image: Image
    let price: Int
}

struct Image: Decodable {
    let width, height: Int
    let url: String
}
