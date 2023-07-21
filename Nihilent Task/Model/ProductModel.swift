//
//  ProductModel.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

struct ProductModel: Identifiable, Codable {
    var id: String {
        return UUID().uuidString
    }
    let products: [ProductDetail]?
}

struct ProductDetail: Codable {
    let title: String
    let id: String
    let imageURL: String
    let ratingCount: Double
    let price: [Price]?
    
    struct Price: Codable {
        let value: Double
    }
    
    var productPrice: String {
        return "$" + String(format: "%.1f", price?.first?.value ?? 0.0)
    }
}

extension ProductDetail {
    var product: Product {
        return Product(
            title: title,
            id: id,
            imageURL: imageURL,
            ratingCount: ratingCount,
            productPrice: productPrice)
    }
}

/**
 
 This is specific to API Model
 
 */

struct Product: Hashable, Equatable {
    let title: String
    let id: String
    let imageURL: String
    let ratingCount: Double
    let productPrice: String
    var isFavorite = Bool.random()
}

/*
 * This is a core domain specific model
 */


extension Product {
    
    static var constant: Product {
        return Product(
            title: "Diamond Label Shiraz",
            id: "23124",
            imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM",
            ratingCount: 4.0,
            productPrice: "6.7")
    }
}
