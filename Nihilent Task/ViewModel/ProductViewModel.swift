//
//  ProductViewModel.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

protocol ProductContract: ObservableObject {
    func fetchProducts()
}

final class ProductViewModel: ProductContract {
    
    enum State {
        case none
        case failure(reason: Error)
        case success(_ products: [Product])
    }
    
    // MARK: - Published Properties
    
    @Published var state: State = .none
    @Published var hasError = false
    
    // MARK: - Private Properties
    
    private let service: Service
    
    // MARK: - Init
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public
    
    func fetchProducts() {
        service.request(with: EndPoint.PRODUCTS_URL, method: .get) { result in
            switch result {
            case let .success(receivedData):
                let productModel: ProductModel? = receivedData.decode()
                self.state = .success((productModel?.products ?? []))
            case let .failure(receivedError):
                self.hasError = true
                self.state = .failure(reason: receivedError)
            }
        }
    }
}
