//
//  ProductsRequest.swift
//  Thirdwayv
//
//  Created by mohammed balegh on 15/12/2022.
//

import Foundation


enum ProductsRequest: RequestProtocol {

    case products

    var url: String {
        NetworkingConstants.baseURL
    }

    var path: String {
        "/aRfWh-"
    }
    var requestType: RequestType {
        .get
    }
}
