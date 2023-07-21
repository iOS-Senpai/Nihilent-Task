//
//  XCTestCase+TrackingMemoryLeaks.swift
//  Nihilent TaskTests
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import XCTest

extension XCTestCase {
    
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak!", file: file, line: line)
        }
    }
}
