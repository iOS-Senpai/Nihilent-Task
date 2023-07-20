//
//  FavoriteView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

struct FavoriteView: View {
    
    var body: some View {
        NavigationView {
            Text("List of Favorite products...")
                .foregroundColor(.red)
                .font(.largeTitle)
                .navigationBarTitle("Favorites", displayMode: .large)
        }
    }
}
struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
