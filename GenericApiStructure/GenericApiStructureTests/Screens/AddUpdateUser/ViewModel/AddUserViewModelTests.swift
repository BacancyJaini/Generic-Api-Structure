//
//  AddUserViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddUserViewModelTests: XCTestCase {
    private var sut: AddUserViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        sut = AddUserViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchUser() {
        let expectation = self.expectation(description: "fetching a user")
        
        let model = 1.requestModel
        sut?.fetchUser(model: model)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testAddOrUpdateProduct() {
        let expectation = self.expectation(description: "add or update user")
        
        let requestModel = AddUpdateUser(firstName: "fname", lastName: "lname", age: 45)
        let type = UserEndPoint.addUser(model: requestModel)
        
        sut?.addOrUpdateUser(type: type)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
