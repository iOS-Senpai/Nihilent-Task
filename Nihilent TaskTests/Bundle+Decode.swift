//
//  Bundle+Decode.swift
//  Nihilent TaskTests
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import Foundation
@testable import Nihilent_Task

extension Bundle {
    
    func resourceData(from fileName: String?) -> Data? {
        guard let resourceURL = url(forResource: fileName, withExtension: "json") else {
            fatalError("Couldn't locate the resource in bundle")
        }
        guard let data = try? Data(contentsOf: resourceURL) else {return nil }
        return data
    }
}

class AnyClassType { }

