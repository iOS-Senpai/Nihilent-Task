//
//  FavoriteButtonView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct FavoriteButtonView: View {
    
    @Environment(\.favorites) private var favorites
    @Environment(\.managedObjectContext) private var context
    let product: Product
    
    var body: some View {
        Image(systemName: hasFavorite(product) ? "heart.fill" : "heart")
            .imageScale(.large)
            .foregroundColor(hasFavorite(product) ? .green : .gray)
            .rotationEffect(Angle(degrees: hasFavorite(product) ? 360 : 0), anchor: .center)
            .onTapGesture {
                setFavoriteState(with: product)
            }
            .animation(.easeInOut(duration: 0.3), value: hasFavorite(product))
    }
    
    func hasFavorite(_ item: Product) -> Bool {
        return favorites.contains { item.id == $0.id }
    }
    
    func setFavoriteState(with item: Product) {
        if hasFavorite(item) {
            //remove
            PersistantManager.shared.delete(object: getFavorite(using: item))
        } else {
            //insert
            let favoriteEntry = FavoriteProduct(context: context)
            favoriteEntry.title = product.title
            favoriteEntry.imageURL = product.imageURL
            favoriteEntry.price = product.productPrice
            favoriteEntry.rating = product.ratingCount
            favoriteEntry.id = product.id
            favoriteEntry.isFavorite = true
            PersistantManager.shared.insert(object: favoriteEntry)
        }
    }
    
    func getFavorite(using product: Product) -> FavoriteProduct {
        return favorites.first { $0.id == product.id } ?? .init()
    }
}

struct FavoriteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButtonView(product: .constant)
    }
}
