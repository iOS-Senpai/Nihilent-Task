//
//  View+Spacing.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import SwiftUI

extension View {
    
    func hSpacing(alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func vSpacing(alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
}
