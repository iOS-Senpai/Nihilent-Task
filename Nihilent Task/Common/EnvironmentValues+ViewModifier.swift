//
//  EnvironmentValues+ViewModifier.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

fileprivate struct ModelEnvironmentKey: EnvironmentKey {
    public static var defaultValue: [FavoriteProduct] = []
}

extension EnvironmentValues {
    var favorites: [FavoriteProduct] {
        get { self[ModelEnvironmentKey.self] }
        set { self[ModelEnvironmentKey.self] = newValue }
    }
}

extension View {
    func configure(_ items: [FavoriteProduct]) -> some View {
        environment(\.favorites, items)
    }
}

struct ModelLoaderModifier: ViewModifier {
    @FetchRequest<FavoriteProduct>(
        entity: FavoriteProduct.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteProduct.title, ascending: true)]) private var cachedProducts
    
    func body(content: Content) -> some View {
        content
            .configure(Array(cachedProducts))
    }
}

extension View {
    
    func loadFavorites() -> some View {
        modifier(ModelLoaderModifier())
    }
}
