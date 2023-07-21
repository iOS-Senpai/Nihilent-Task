//
//  ProductDetailView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct ProductDetailView: View {
    
    let product: Product
    
    var body: some View {
        VStack {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: product.imageURL)) {
                    ProgressView()
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.75)
                VStack {
                    FavoriteButtonView(product: product)
                        .padding(.horizontal, 24)
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text(product.title)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(1)
                    
                    Text(product.productPrice)
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                
                HStack {
                    RatingsView(rating: Int(product.ratingCount))
                }
                .padding(.trailing, 24)
                .hSpacing(alignment: .trailing)
            }
            .padding(.top, 24)
            .padding(.horizontal, 12)
            .hSpacing(alignment: .leading)
        }
        .navigationBarTitle(product.title, displayMode: .inline)
        .vSpacing(alignment: .top)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: .constant)
    }
}
