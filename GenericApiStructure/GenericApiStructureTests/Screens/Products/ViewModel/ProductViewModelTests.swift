//
//  ProductViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductViewModelTests: XCTestCase {
    private var viewModelUnderTest: ProductViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        viewModelUnderTest = ProductViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelUnderTest = nil
    }

    func testInitialization() {
        XCTAssertNotNil(viewModelUnderTest)
    }
    
    func testFetchProducts() {
        let expectation = self.expectation(description: "fetching products")
        
        viewModelUnderTest?.fetchProducts()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            expectation.fulfill()
            XCTAssertTrue(viewModelUnderTest?.products.count ?? 0 > 0)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDeleteProduct() {
        let expectation = self.expectation(description: "deleting product")
        
        let model = DataRequestModel(id: 1)
        viewModelUnderTest?.deleteProduct(model: model, index: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchProducts() {
        let expectation = self.expectation(description: "searching products")
        let model = SearchData(q: "iPhone")
        viewModelUnderTest?.searchProducts(model: model)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            XCTAssertTrue(viewModelUnderTest?.products.count ?? 0 > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
