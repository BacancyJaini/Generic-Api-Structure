//
//  Encodable+ExtensionTests.swift
//  GenericApiStructureTests
//
//  Created by user on 07/12/23.
//

import XCTest
@testable import GenericApiStructure

final class Encodable_ExtensionTests: XCTestCase {
    private var modelUnderTest: SearchData!
    
    override func setUp() {
        super.setUp()
        modelUnderTest = SearchData(q: "test")
    }
    
    override func tearDown() {
        super.tearDown()
        modelUnderTest = nil
    }
    
    func testEncodable() {
        XCTAssertNotNil(modelUnderTest.convertToURLQueryItems())
    }
}
