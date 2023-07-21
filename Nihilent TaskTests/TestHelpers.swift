//
//  TestHelpers.swift
//  Nihilent TaskTests
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import Foundation
@testable import Nihilent_Task

// MARK: - DSL

func anyURL() -> URL {
    return "http://a-url.com/"
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func anyError() -> Error {
    return NSError(domain: "domain", code: 1)
}

func nError() -> NError {
    return NError.underlyingError(anyError())
}

func emptyData() -> Data {
    return Data()
}
