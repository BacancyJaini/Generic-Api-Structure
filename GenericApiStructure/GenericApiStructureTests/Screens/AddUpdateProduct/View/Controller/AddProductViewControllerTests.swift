//
//  AddProductViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddProductViewControllerTests: XCTestCase {
    private var sut: AddProductViewController!
    
    override func setUp() {
        super.setUp()
        sut = Storyboards.main.viewController(vc: AddProductViewController.self)
        sut.product = "Product".loadJson(ofType: Product.self)
        sut.loadViewIfNeeded()        
        sut.addProductViewModel = AddProductViewModel(serviceManager: MockServiceManager())
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testNavTitle() {
        XCTAssertEqual(sut.navigationItem.title, Constants.kUpdateHeader)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.productImageView)
        XCTAssertNotNil(sut.titleTextField)
        XCTAssertNotNil(sut.descriptionTextField)
        XCTAssertNotNil(sut.addUpdateButton)
    }
    
    func testDelegate() {
        XCTAssertTrue(sut.conforms(to: UITextFieldDelegate.self))
    }
    
    func testUpdateData() {
        XCTAssertEqual(sut.addUpdateButton.currentTitle, Constants.kUpdateButton)
        XCTAssertEqual(sut.titleTextField.text, sut.product?.title)
        XCTAssertEqual(sut.descriptionTextField.text, sut.product?.description)
    }
    
    func testRequestModel() {
        let requestModel = sut.getRequestModel()
        XCTAssertNotNil(requestModel)
    }
    
    func testButtonAction() {
        sut.addUpdateButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(sut.addUpdateButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
    }
    
    func testTextFieldShouldReturn() {
        XCTAssertNotNil(sut.textFieldShouldReturn(sut.titleTextField))
        XCTAssertNotNil(sut.textFieldShouldReturn(sut.descriptionTextField))
    }
}
