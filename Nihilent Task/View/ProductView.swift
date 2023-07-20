//
//  ProductView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct ProductView: View {
    
    // MARK: - Single Source Of Truth
    
    @StateObject private var vm = ProductViewModel(service: MainDispatchQueueDecorator(NetWorkService()))
    
    var body: some View {
        NavigationView {
            VStack {
                switch vm.state {
                case .none:
                    ProgressView() {
                        Text("Fetching products...")
                            .font(.title)
                            .foregroundColor(.gray)
                    }
                    .progressViewStyle(CircularProgressViewStyle(tint: .purple))
                case let .success(products):
                    List {
                        ForEach(products, id:\.id) { product in
                            Text(product.title)
                        }
                    }
                case let .failure(reason: error):
                    Text(error.localizedDescription)
                }
            }
            .navigationBarTitle("Products", displayMode: .large)
        }
        .onAppear {
            vm.fetchProducts()
        }
    }
}

struct ProductRow: View {
    
    let product: Product
    
    var body: some View {
        HStack {
            
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
