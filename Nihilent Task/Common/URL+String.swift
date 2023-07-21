//
//  URL+String.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

extension URL: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: StaticString) {
        self = URL(string: "\(value)")!
    }
}
