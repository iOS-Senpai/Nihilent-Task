//
//  URLConveritble+String.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

protocol URLConveritble {
    func asURL() -> URL?
}

extension String: URLConveritble {
    
    func asURL() -> URL? {
        guard let url = URL(string: self) else {
            return nil
        }
        return url
    }
}
