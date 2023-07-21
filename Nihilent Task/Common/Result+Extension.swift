//
//  Result+Extension.swift
//  Nihilent Task
//
//  Created by Pradeep Kumar on 2023/07/20.
//

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
