//
//  ContentUnavailableView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct ContentUnavailableView: View {
    
    var body: some View {
        VStack {
            Image(systemName: "heart.slash")
                .font(.system(size: 100, weight: .bold))
                .foregroundColor(Color.red)
                .padding()
            
            Text("No Favorites Found.\n Select any of them to make to your favorite.")
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .font(.system(.headline))
        }
        .vSpacing(alignment: .center)
    }
}

struct ContentUnavailableView_Previews: PreviewProvider {
    static var previews: some View {
        ContentUnavailableView()
    }
}
