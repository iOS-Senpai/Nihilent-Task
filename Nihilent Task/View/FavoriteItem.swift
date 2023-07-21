//
//  FavoriteItem.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct FavoriteItem: View {
  
    @State private var isDeleteIconSelected = false
    @Environment(\.favorites) private var favorites
    let product: Product
    
    var body: some View {
        HStack {
            ItemView(product: product)
            HStack {
                DeleteButtonView(selected: $isDeleteIconSelected)
            }
            .padding(.trailing, 12)
            .hSpacing(alignment: .trailing)
        }
        .hSpacing(alignment: .leading)
        .onChange(of: isDeleteIconSelected) { value in
            if value {
                PersistantManager.shared.delete(object: cachedProduct)
            }
        }
    }
    
    private var cachedProduct: FavoriteProduct {
        return favorites.first { $0.id == product.id } ?? .init()
    }
}

struct FavoriteItem_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteItem(product: .constant)
    }
}
