//
//  NoDataTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class NoDataTableViewCellTests: XCTestCase {

    private var sut: NoDataTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = Bundle.main.loadNibNamed("NoDataTableViewCell", owner: self, options: nil)?.first as? NoDataTableViewCell
        sut.noData = Constants.kNoData
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.noDataLabel)
    }
    
    func testNoDataTitle() {
        XCTAssertEqual(sut.noDataLabel.text, Constants.kNoData)
    }
}
