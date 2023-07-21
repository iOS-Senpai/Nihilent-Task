//
//  URLRequestConvertible+URLRequest.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import Foundation

protocol URLRequestConvertible {
    func asURLRequest() -> URLRequest?
}

extension URLRequest: URLRequestConvertible {
    func asURLRequest() -> URLRequest? {
        return self
    }
}

extension URLRequest {
    
    init?(url: URLConveritble, method: HTTPMethod) {
        guard let url = url.asURL() else {
            return nil
        }
        self.init(url: url)
        httpMethod = method.rawValue
    }
}

struct RequestConvertible: URLRequestConvertible {
    let url: URLConveritble
    let method: HTTPMethod
    func asURLRequest() -> URLRequest? {
        let request = URLRequest(url: url, method: method)
        return request
    }
}
