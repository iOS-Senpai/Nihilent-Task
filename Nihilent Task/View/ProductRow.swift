//
//  ProductRow.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct ProductRow: View {
    
    let product: Product

    var body: some View {
        HStack {
            ItemView(product: product)
            VStack {
                AddToCartButtonView()
            }
            .padding(.trailing, 4)
            .hSpacing(alignment: .trailing)
            .vSpacing(alignment: .bottom)
        }
        .overlay(FavoriteButtonView(product: product),
                 alignment: .topTrailing)
        .hSpacing(alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductRow(product: .constant)
            .frame(width: 400, height: 150)
    }
}
