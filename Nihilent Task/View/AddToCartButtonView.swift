//
//  AddToCartButtonView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct AddToCartButtonView: View {
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 22)
                .fill(.red.opacity(0.2))
                .frame(width: 100, height: 44)
            Text("ADD")
                .fontWeight(.bold)
                .foregroundColor(.red)
            
            VStack(alignment: .trailing) {
                Image(systemName: "plus")
                    .imageScale(.small)
                    .foregroundColor(.red)
            }
            .offset(x: 28, y: -10)
        }
        .onTapGesture {
            print("Button Tapped")
        }
    }
}

struct AddToCartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddToCartButtonView()
    }
}
