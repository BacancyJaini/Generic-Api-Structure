//
//  ProductsTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductsTableViewCellTests: XCTestCase {
    private var cellUnderTest: ProductsTableViewCell!
    
    override func setUp() {
        super.setUp()
        cellUnderTest = Bundle.main.loadNibNamed("ProductsTableViewCell", owner: self, options: nil)?.first as? ProductsTableViewCell
        cellUnderTest.product = "Product".loadJson(ofType: Product.self)
    }
    
    override func tearDown() {
        super.tearDown()
        cellUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(cellUnderTest)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(cellUnderTest.productImageView)
        XCTAssertNotNil(cellUnderTest.productBackgroundView)
        XCTAssertNotNil(cellUnderTest.titleLabel)
        XCTAssertNotNil(cellUnderTest.descriptionLabel)
        XCTAssertNotNil(cellUnderTest.priceLabel)
        XCTAssertNotNil(cellUnderTest.buyButton)
    }
    
    func testProductNotNil() {
        XCTAssertNotNil(cellUnderTest.product)
    }
     
    func testProductData() {
        XCTAssertEqual(cellUnderTest.titleLabel.text, cellUnderTest.product?.title)
        XCTAssertEqual(cellUnderTest.descriptionLabel.text, cellUnderTest.product?.description)
        XCTAssertEqual(cellUnderTest.priceLabel.text, (cellUnderTest.product?.price ?? Constants.kZero).priceWithCurrency)
    }
}
