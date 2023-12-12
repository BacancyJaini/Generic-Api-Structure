//
//  ProductsTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductsTableViewCellTests: XCTestCase {
    private var sut: ProductsTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = Bundle.main.loadNibNamed("ProductsTableViewCell", owner: self, options: nil)?.first as? ProductsTableViewCell
        sut.product = "Product".loadJson(ofType: Product.self)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.productImageView)
        XCTAssertNotNil(sut.productBackgroundView)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertNotNil(sut.priceLabel)
        XCTAssertNotNil(sut.buyButton)
    }
    
    func testProductNotNil() {
        XCTAssertNotNil(sut.product)
    }
     
    func testProductData() {
        XCTAssertEqual(sut.titleLabel.text, sut.product?.title)
        XCTAssertEqual(sut.descriptionLabel.text, sut.product?.description)
        XCTAssertEqual(sut.priceLabel.text, (sut.product?.price ?? Constants.kZero).priceWithCurrency)
    }
}
