//
//  NError+Error.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

enum NError: Error {
    case underlyingError(_ error: Error)
    case badURL
    case badRequest
}

extension NError: Equatable {
    
    static func == (lhs: NError, rhs: NError) -> Bool {
        switch (lhs, rhs) {
        case (.badURL, .badURL): return true
        case (.underlyingError, .underlyingError): return true
        case (.badRequest, .badRequest): return true
        default: return false
        }
    }
}
