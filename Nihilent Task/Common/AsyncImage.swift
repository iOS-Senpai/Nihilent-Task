//
//  AsyncImage.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI
import Combine

struct AsyncImage<Content: View>: View {
    
    @StateObject private var imageLoader: ImageLoader
    private let currentContent: Content
    
    init(url: URL?, @ViewBuilder content: @escaping () -> Content) {
        self.currentContent = content()
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: imageLoader.load)
    }
    
    private var content: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                currentContent
            }
        }
    }
}
