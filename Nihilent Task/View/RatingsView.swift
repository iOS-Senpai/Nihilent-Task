//
//  RatingsView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct RatingsView: View {
    
    let rating: Int
    
    var body: some View {
        ForEach(0..<rating, id:\.self) { index in
            Image(systemName: "star.fill")
                .foregroundColor(.red)
        }
    }
}

struct RatingsView_Previews: PreviewProvider {
    static var previews: some View {
        RatingsView(rating: 4)
    }
}
