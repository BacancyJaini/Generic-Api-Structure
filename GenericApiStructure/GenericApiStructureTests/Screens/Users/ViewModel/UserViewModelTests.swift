//
//  UserViewModelTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class UserViewModelTests: XCTestCase {
    private var viewModelUnderTest: UserViewModel?

    override func setUp() {
        super.setUp()
        let mockServiceManager = MockServiceManager()
        viewModelUnderTest = UserViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelUnderTest = nil
    }

    func testInitialization() {
        XCTAssertNotNil(viewModelUnderTest)
    }
    
    func testFetchUsers() {
        let expectation = self.expectation(description: "fetching users")
        
        viewModelUnderTest?.fetchUsers()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            expectation.fulfill()
            XCTAssertTrue(viewModelUnderTest?.users.count ?? 0 > 0)
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testDeleteUser() {
        let expectation = self.expectation(description: "deleting user")
        
        let model = 1.requestModel
        viewModelUnderTest?.deleteUser(model: model, index: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSearchUsers() {
        let expectation = self.expectation(description: "searching users")
        let model = SearchData(q: "terry")
        viewModelUnderTest?.searchUsers(model: model)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            XCTAssertTrue(viewModelUnderTest?.users.count ?? 0 > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
