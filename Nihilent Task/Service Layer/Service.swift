//
//  Service.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

import Foundation

protocol Service: AnyObject {
    typealias Result = Swift.Result<Data, NError>
    func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Service.Result) -> Void)
}

final class NetWorkService: Service {
    
    func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Service.Result) -> Void) {
        let request = RequestConvertible(url: url, method: method)
        perform(request, completion: completion)
    }
    
    private func perform(_ request: URLRequestConvertible, completion: @escaping (Service.Result) -> Void) {
        guard let request = request.asURLRequest() else {
            completion(.failure(.badRequest))
            return
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            let nError = error.map { NError.underlyingError($0) }
            completion(Result(success: data, failure: nError))
        }
        task.resume()
    }
}
/**
 
 This is a basic service layer abstration, generally we can extend and create more complex functionality to this abstraction for supporting multiple requests types.
 
 */
