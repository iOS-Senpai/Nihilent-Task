//
//  Collection+Extension.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

extension Collection where Element == FetchedResults<FavoriteProduct>.Element {
    
    func toProduct() -> [Product] {
        return self.map {
            Product(title: $0.title ?? "",
                    id: $0.id ?? "",
                    imageURL: $0.imageURL ?? "",
                    ratingCount: $0.rating,
                    productPrice: $0.price ?? "")
        }.removeDuplicates()
    }
}
