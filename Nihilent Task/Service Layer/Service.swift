//
//  Service.swift
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

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Service {
    typealias Result = Swift.Result<Data, NError>
    func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Service.Result) -> Void)
}

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

extension Result {
    
    init(success: Success?, failure: Failure?) {
        if let value = success {
            self = .success(value)
        } else if let error = failure {
            self = .failure(error)
        } else {
            fatalError("Couldn't create result")
        }
    }
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
 
 This is a basic service layer abstration, generally we can extend and create more complex functionality to this abstrction for supporting multiple requests.
 
 */

// DispatchQueueDecorator for injecting side effect. Threading is a cross cutting concern. Instead of implementing this in all over places we can inject at one place.

final class MainDispatchQueueDecorator: Service {
    
    private let decoratee: Service
    
    init(_ decoratee: Service) {
        self.decoratee = decoratee
    }
    
    func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Result<Data, NError>) -> Void) {
        self.decoratee.request(with: url, method: method) { [weak self] (result) in
            self?.dispatchQueueAction {
                completion(result)
            }
        }
    }
}

extension MainDispatchQueueDecorator {
    
    func dispatchQueueAction(action: @escaping () -> Void) {
        if Thread.isMainThread {
            action()
        } else {
            DispatchQueue.main.async {
                action()
            }
        }
    }
}
