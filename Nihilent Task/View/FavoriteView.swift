//
//  FavoriteView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct FavoriteView: View {
    
    @Environment(\.favorites) private var favorites
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    ForEach(products, id: \.id) { product in
                        NavigationLink {
                            ProductDetailView(product: product)
                        } label: {
                            FavoriteItem(product: product)
                                .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        }
                    }
                }
                .listStyle(.plain)
                
                if favorites.isEmpty {
                    ContentUnavailableView()
                        .vSpacing(alignment: .center)
                        .hSpacing(alignment: .center)
                }
            }
            .navigationBarTitle("Favorites", displayMode: .large)
        }
        .padding(.trailing, -32)
    }
    
    // MARK: - Computed Properties
    private var products: [Product] {
        return favorites.toProduct()
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
