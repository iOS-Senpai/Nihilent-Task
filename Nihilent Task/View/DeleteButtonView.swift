//
//  DeleteButtonView.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import SwiftUI

struct DeleteButtonView: View {
    
    @Binding var selected: Bool
    
    var body: some View {
        Button(action: {
            self.selected = true
        }) {
            Image(systemName: "trash")
                .imageScale(.large)
                .foregroundColor(selected ? .green : .gray)
                .rotationEffect(Angle(degrees: selected ? 360 : 0), anchor: .center)
        }
        .animation(.easeInOut(duration: 0.3), value: selected)
        .buttonStyle(.borderless)
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonView(selected: .constant(false))
    }
}
