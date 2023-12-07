//
//  AddUserViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddUserViewModelTests: XCTestCase {
    private var viewModelUnderTest: AddUserViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        viewModelUnderTest = AddUserViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelUnderTest = nil
    }

    func testInitialization() {
        XCTAssertNotNil(viewModelUnderTest)
    }
    
    func testFetchUser() {
        let expectation = self.expectation(description: "fetching a user")
        
        let model = 1.requestModel
        viewModelUnderTest?.fetchUser(model: model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAddOrUpdateProduct() {
        let expectation = self.expectation(description: "add or update user")
        
        let requestModel = AddUpdateUser(firstName: "fname", lastName: "lname", age: 45)
        let type = UserEndPoint.addUser(model: requestModel)
        
        viewModelUnderTest?.addOrUpdateUser(type: type)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
