//
//  MainTabView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct MainTabView: View {
    
    enum TabSelectionState {
        case products
        case favorites
    }
    
    // MARK: - Properties
    
    @State private var selectedTab: TabSelectionState = .products
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ProductView()
                .tabItem {
                    Label("Product", systemImage: SFSymbols.products)
                }
                .tag(TabSelectionState.products)
                .foregroundColor(.red)
            
            FavoriteView()
                .tabItem {
                    Label("Favorite", systemImage: SFSymbols.favorites)
                }
                .tag(TabSelectionState.favorites)
        }
        .loadFavorites()
        .accentColor(.red)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
