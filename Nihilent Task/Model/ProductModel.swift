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
    let products: [Product]?
}

struct Product: Codable {
    let title: String
    let id: String
    let imageURL: String
    let ratingCount: Double
}
