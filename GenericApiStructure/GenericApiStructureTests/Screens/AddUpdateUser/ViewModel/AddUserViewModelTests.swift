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
}
