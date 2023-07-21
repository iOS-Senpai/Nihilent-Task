//
//  ItemView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct ItemView: View {
    
    let product: Product
    var body: some View {
        AsyncImage(url: URL(string: product.imageURL)) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .red))
        }
        .frame(width: .productImageWidth, height: .productImageHeight)
        .aspectRatio(contentMode: .fill)
        
        VStack(alignment: .leading, spacing: 12) {
            Text(product.title)
                .font(.callout)
                .fontWeight(.semibold)
                .lineLimit(2)
            Text(product.productPrice)
                .font(.caption)
                .fontWeight(.semibold)
        }
        .foregroundColor(.black)
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(product: .constant)
    }
}
