//
//  Collection+RemoveDuplicates.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import Foundation

extension Collection where Element: Hashable {
    
    func removeDuplicates() -> [Element] {
        return Array(Set<Element>(self))
    }
}
