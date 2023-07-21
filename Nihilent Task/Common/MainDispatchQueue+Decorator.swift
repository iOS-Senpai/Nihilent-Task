//
//  MainDispatchQueue+Decorator.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

// DispatchQueueDecorator for injecting side effect. Threading is a cross cutting concern. Instead of implementing this in all over places we can inject at one place.

final class MainDispatchQueueDecorator: Service {
    
    private let decoratee: Service
    
    init(_ decoratee: Service) {
        self.decoratee = decoratee
    }
    
    func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Result<Data, NError>) -> Void) {
        self.decoratee.request(with: url, method: method) { [weak self] (result) in
            self?.dispatchQueueAction {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator {
    
    func dispatchQueueAction(action: @escaping () -> Void) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
