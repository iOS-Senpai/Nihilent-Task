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
                            NavigationLink {
                                ProductDetailView(product: product)
                            } label: {
                                ProductRow(product: product)
                                    .listRowInsets(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                            }
                        }
                    }
                    .listStyle(.plain)
                case let .failure(reason: error):
                    Text(error.localizedDescription)
                }
            }
            .onAppear {
                vm.fetchProducts()
            }
            .navigationBarTitle("Products", displayMode: .large)
        }
        .padding(.trailing, -32)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
