//
//  NoDataTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class NoDataTableViewCellTests: XCTestCase {

    private var cellUnderTest: NoDataTableViewCell!
    
    override func setUp() {
        super.setUp()
        cellUnderTest = Bundle.main.loadNibNamed("NoDataTableViewCell", owner: self, options: nil)?.first as? NoDataTableViewCell
        cellUnderTest.noData = Constants.kNoData
    }
    
    override func tearDown() {
        super.tearDown()
        cellUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(cellUnderTest)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(cellUnderTest.noDataLabel)
    }
    
    func testNoDataTitle() {
        XCTAssertEqual(cellUnderTest.noDataLabel.text, Constants.kNoData)
    }
}
