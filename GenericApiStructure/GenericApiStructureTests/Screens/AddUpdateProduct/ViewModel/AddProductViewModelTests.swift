//
//  AddProductViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddProductViewModelTests: XCTestCase {
    private var viewModelUnderTest: AddProductViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        viewModelUnderTest = AddProductViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelUnderTest = nil
    }

    func testInitialization() {
        XCTAssertNotNil(viewModelUnderTest)
    }
    
    func testFetchProduct() {
        let expectation = self.expectation(description: "fetching a product")
        
        let model = 1.requestModel
        viewModelUnderTest?.fetchProduct(model: model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAddOrUpdateProduct() {
        let expectation = self.expectation(description: "add or update product")
        
        let requestModel = AddUpdateProduct(title: "test", description: "test desc")
        let type = ProductEndPoint.addProduct(model: requestModel)
        
        viewModelUnderTest?.addOrUpdateProduct(type: type)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
