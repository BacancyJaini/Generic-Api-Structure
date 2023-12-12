//
//  ProductViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductViewModelTests: XCTestCase {
    private var sut: ProductViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        sut = ProductViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchProducts() {
        let expectation = self.expectation(description: "fetching products")
        
        sut?.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            expectation.fulfill()
            XCTAssertTrue(sut?.products.count ?? 0 > 0)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDeleteProduct() {
        let expectation = self.expectation(description: "deleting product")
        
        let model = 1.requestModel
        sut?.deleteProduct(model: model, index: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchProducts() {
        let expectation = self.expectation(description: "searching products")
        let model = SearchData(q: "iPhone")
        sut?.searchProducts(model: model)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            XCTAssertTrue(sut?.products.count ?? 0 > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
