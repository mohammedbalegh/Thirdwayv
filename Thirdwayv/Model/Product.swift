//
//  Product.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation

struct Product: Codable {
    let id: Int
    let productDescription: String
    let image: Image
    let price: Int
}

struct Image: Codable {
    let width, height: Int
    let url: String
}
