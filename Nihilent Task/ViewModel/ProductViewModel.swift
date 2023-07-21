//
//  ProductViewModel.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

final class ProductViewModel: ObservableObject {
    
    enum State {
        case none
        case failure(reason: Error)
        case success(_ products: [Product])
    }
    
    // MARK: - Published Properties
    
    @Published var state: State = .none
    @Published var hasError = false
    
    // MARK: - Private Properties
    
    private let service: Service?
    private var isLoading = false
    
    // MARK: - Init
    
    init(service: Service) {
        self.service = service
    }
    
    // MARK: - Public
    
    func fetchProducts(completion: @escaping (ProductViewModel.State) -> Void = { _ in }) {
        service?.request(with: EndPoint.PRODUCTS_URL, method: .get) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(receivedData):
                let productModel: ProductModel? = receivedData.decode()
                let products = productModel?.products?.asProduct() ?? []
                self.state = .success(products)
                self.isLoading = false
                completion(.success(products))
            case let .failure(receivedError):
                self.hasError = true
                self.state = .failure(reason: receivedError)
                self.isLoading = false
                completion(.failure(reason: receivedError))
            }
        }
    }
    
    deinit {
        print("Instance have been deallocated....")
    }
}

extension ProductViewModel.State: Equatable {
    
    static func == (lhs: ProductViewModel.State, rhs: ProductViewModel.State) -> Bool {
        switch (lhs, rhs) {
        case (.none, .none): return true
        case let (.failure(receivedError as NError), .failure(expectedError as NError)): return receivedError == expectedError
        case let (.success(receivedProducts), .success(expectedProducts)): return receivedProducts == expectedProducts
        default: return false
        }
    }
}

// MARK: - Private Extension

private extension Array where Element == ProductDetail {
    
    func asProduct() -> [Product] {
        return self.compactMap { $0.product }
    }
}
