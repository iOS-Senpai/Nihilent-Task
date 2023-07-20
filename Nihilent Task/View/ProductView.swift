//
//  ProductView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct ProductView: View {
    
    var body: some View {
        NavigationView {
            Text("List of products...")
                .foregroundColor(.red)
                .font(.largeTitle)
                .navigationBarTitle("Products", displayMode: .large)
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
