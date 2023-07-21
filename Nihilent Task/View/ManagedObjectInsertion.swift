//
//  ManagedObjectInsertion.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct ManagedObjectInsertion: ViewModifier {
    @FetchRequest<FavoriteProduct>(
        entity: FavoriteProduct.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteProduct.title, ascending: true)]) private var cachedProducts
    @Environment(\.managedObjectContext) private var context
    
    let isSelected: Bool
    let product: Product
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isSelected) { newValue in
                if newValue {
                    let favoriteEntry = FavoriteProduct(context: context)
                    favoriteEntry.title = product.title
                    favoriteEntry.imageURL = product.imageURL
                    favoriteEntry.price = product.productPrice
                    favoriteEntry.rating = product.ratingCount
                    favoriteEntry.id = product.id
                    favoriteEntry.isFavorite = true
                    PersistantManager.shared.insert(object: favoriteEntry)
                } else {
                    PersistantManager.shared.delete(object: cachedProduct)
                }
            }
    }
    
    private var cachedProduct: FavoriteProduct {
        return cachedProducts.first { $0.id == product.id } ?? .init()
    }
}

extension View {
    
    func insertManagedObject(selected: Bool, product: Product) -> some View {
        modifier(ManagedObjectInsertion(isSelected: selected, product: product))
    }
}

