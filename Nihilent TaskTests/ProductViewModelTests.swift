//
//  ProductViewModelTests.swift
//  Nihilent TaskTests
//
//  Created by Pradeep Kumar on 2023/07/21.
//

import XCTest
@testable import Nihilent_Task

final class ProductViewModelTests: XCTestCase {
    
    func test_degenarate() {
        let (sut, _) = makeSUT()
        XCTAssertFalse(sut.hasError, "Expected error to be false")
        XCTAssertEqual(sut.state, .none, "Expected the state should be none")
    }
    
    func test_fetchproducts_performRequestForURL() {
        //Given
        let (sut, spy) = makeSUT()
        
        //When
        sut.fetchProducts()
        
        //Then
        XCTAssertEqual(spy.urls, [URL(string: EndPoint.PRODUCTS_URL)!])
    }
    
    func test_fetchproducts_performRequestForURLTwice() {
        //Given
        let (sut, spy) = makeSUT()
        
        //When
        sut.fetchProducts()
        
        //Then
        XCTAssertEqual(spy.urls.count, 1)
    }
    
    func test_fetchproducts_deliversEmptyProductsWithEmptyData() {
        
        //Given
        let (sut, spy) = makeSUT()
        
        //When
        sut.fetchProducts()
        
        // Then
        expect(sut, spy, toCompletedWith: .success([])) {
            spy.toCompleteWithSuccess(data: anyData())
        }
    }
    
    func test_fetchproducts_deliversErrorWhenRequestFails() {
        //Given
        let (sut, spy) = makeSUT()
        
        //When
        sut.fetchProducts()
        
        // Then
        expect(sut, spy, toCompletedWith: .failure(reason: nError())) {
            spy.toCompleteWithError(error: nError())
        }
    }
    
    func test_fetchproducts_deliversResultWithSuccess() {
        //Given
        let (sut, spy) = makeSUT()
        
        //When
        sut.fetchProducts()
        
        // Then
        let data: Data = Bundle(for: ProductViewModelTests.self).resourceData(from: "ProductModel") ?? .init()
        expect(sut, spy, toCompletedWith: .success(Product.mockProducts)) {
            spy.toCompleteWithSuccess(data: data)
        }
    }
    
    func test_fetchproducts_doesnotDeliverResultsWhenSUTInstanceHasBeenDeallocated() {
        //Given
        let spy = ViewModelSpy()
        var sut: ProductViewModel? = ProductViewModel(service: spy)
        var capturedState = [ProductViewModel.State]()
        
        // When
        sut?.fetchProducts { capturedState.append($0) }
        sut = nil
        spy.toCompleteWithSuccess(data: Data())
        
        //Then
        XCTAssertTrue(capturedState.isEmpty)
    }
}

// MARK: - Private

private extension Product {
    static var mockProducts: [Product] {
        return [
            Product(title: "Diamond",
                    id: "23124",
                    imageURL: "https://media.danmurphys.com.au/dmo/product/23124-1.png?impolicy=PROD_SM",
                    ratingCount: 4.0,
                    productPrice: "$9.4")
        ]
    }
}

private extension ProductViewModelTests {
    
    // MARK: - Helpers
    
    func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ProductViewModel, ViewModelSpy) {
        let spy = ViewModelSpy()
        let viewModel = ProductViewModel(service: spy)
        return (viewModel, spy)
    }
    
    func expect(_ sut: ProductViewModel,
                _ spy: ViewModelSpy,
                toCompletedWith expectedResult: ProductViewModel.State,
                when action: @escaping () -> Void,
                file: StaticString = #file,
                line: UInt = #line) {
        let expectation = expectation(description: "wait for completion")
        spy.onCompletion = {
            XCTAssertEqual(sut.state, expectedResult, file: file, line: line)
            expectation.fulfill()
        }
        action()
        wait(for: [expectation], timeout: 1.0)
    }
    
    class ViewModelSpy: Service {
        
        enum State {
            case success
            case failure
        }
        
        var state: State = .success
        private(set) var messages = [(url: URLConveritble, completion: (Service.Result) -> Void)]()
        var onCompletion: (() -> Void)?
        
        var urls: [URL] {
            return messages.map { $0.url.asURL() ?? anyURL() }
        }
        
        func request(with url: URLConveritble, method: HTTPMethod, completion: @escaping (Service.Result) -> Void) {
            messages.append((url, completion))
        }
        
        func toCompleteWithSuccess(data: Data, at index: Int = 0) {
            messages[index].completion(.success(data))
            onCompletion?()
        }
        
        func toCompleteWithError(error: NError, at index: Int = 0) {
            messages[index].completion(.failure(error))
            onCompletion?()
        }
    }
}
