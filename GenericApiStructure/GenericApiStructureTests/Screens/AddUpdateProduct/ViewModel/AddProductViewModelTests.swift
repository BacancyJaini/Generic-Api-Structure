//
//  AddProductViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddProductViewModelTests: XCTestCase {
    private var sut: AddProductViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        sut = AddProductViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchProduct() {
        let expectation = self.expectation(description: "fetching a product")
        
        let model = 1.requestModel
        sut?.fetchProduct(model: model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAddOrUpdateProduct() {
        let expectation = self.expectation(description: "add or update product")
        
        let requestModel = AddUpdateProduct(title: "test", description: "test desc")
        let type = ProductEndPoint.addProduct(model: requestModel)
        
        sut?.addOrUpdateProduct(type: type)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
