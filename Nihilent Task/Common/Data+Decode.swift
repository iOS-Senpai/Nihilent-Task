//
//  Data+Decode.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

extension Data {
    
    func decode<T: Decodable>(of type: T.Type = T.self) -> T? {
        try? JSONDecoder().decode(type, from: self)
    }
}
