//
//  Encodable+ExtensionTests.swift
//  GenericApiStructureTests
//
//  Created by user on 07/12/23.
//

import XCTest
@testable import GenericApiStructure

final class Encodable_ExtensionTests: XCTestCase {
    private var sut: SearchData!
    
    override func setUp() {
        super.setUp()
        sut = SearchData(q: "test")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testEncodable() {
        XCTAssertNotNil(sut.convertToURLQueryItems())
    }
}
