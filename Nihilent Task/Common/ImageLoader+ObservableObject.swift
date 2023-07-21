//
//  ImageLoader+ObservableObject.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Combine
import SwiftUI

class ImageLoader: ObservableObject {
    
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private(set) var isLoading = false
    
    private let url: URL?
    
    init(url: URL?) {
        self.url = url
    }
    
    func load() {
        guard !isLoading else { return }
        
        if let url = url {
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .handleEvents(receiveSubscription: { [weak self] _ in
                    self?.onStart()
                }, receiveCompletion: { [weak self] _ in
                    self?.onFinish()
                }, receiveCancel: { [weak self] in
                    self?.onFinish()
                })
                .receive(on: DispatchQueue.main)
                .sink { [weak self] in self?.image = $0 }
        }
    }
    
    func onStart() {
        isLoading = true
    }
    
    func onFinish() {
        isLoading = false
    }
    
    func cancel() {
        cancellable?.cancel()
    }
    
    deinit {
        cancel()
    }
}
