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
}
