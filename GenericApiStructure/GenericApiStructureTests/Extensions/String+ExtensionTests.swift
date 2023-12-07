//
//  String+ExtensionTests.swift
//  GenericApiStructureTests
//
//  Created by user on 07/12/23.
//

import XCTest
@testable import GenericApiStructure

final class String_ExtensionTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testPathWithId() {
        let path = "products".pathWithId(id: 1)
        XCTAssertNotNil(path)
    }
}
