//
//  AddProductViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddProductViewControllerTests: XCTestCase {
    private var viewControllerUnderTest: AddProductViewController!
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = Storyboards.main.viewController(vc: AddProductViewController.self)
        viewControllerUnderTest.product = "Product".loadJson(ofType: Product.self)
        viewControllerUnderTest.loadViewIfNeeded()        
        viewControllerUnderTest.addProductViewModel = AddProductViewModel(serviceManager: MockServiceManager())
    }
    
    override func tearDown() {
        super.tearDown()
        viewControllerUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testNavTitle() {
        XCTAssertEqual(viewControllerUnderTest.navigationItem.title, Constants.kUpdateHeader)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(viewControllerUnderTest.productImageView)
        XCTAssertNotNil(viewControllerUnderTest.titleTextField)
        XCTAssertNotNil(viewControllerUnderTest.descriptionTextField)
        XCTAssertNotNil(viewControllerUnderTest.addUpdateButton)
    }
    
    func testDelegate() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITextFieldDelegate.self))
    }
    
    func testUpdateData() {
        XCTAssertEqual(viewControllerUnderTest.addUpdateButton.currentTitle, Constants.kUpdateButton)
        XCTAssertEqual(viewControllerUnderTest.titleTextField.text, viewControllerUnderTest.product?.title)
        XCTAssertEqual(viewControllerUnderTest.descriptionTextField.text, viewControllerUnderTest.product?.description)
    }
    
    func testRequestModel() {
        let requestModel = viewControllerUnderTest.getRequestModel()
        XCTAssertNotNil(requestModel)
    }
    
    func testButtonAction() {
        viewControllerUnderTest.addUpdateButton.sendActions(for: .touchUpInside)
        XCTAssertNotNil(viewControllerUnderTest.addUpdateButton.actions(forTarget: viewControllerUnderTest, forControlEvent: .touchUpInside))
    }
    
    func testTextFieldShouldReturn() {
        XCTAssertNotNil(viewControllerUnderTest.textFieldShouldReturn(viewControllerUnderTest.titleTextField))
        XCTAssertNotNil(viewControllerUnderTest.textFieldShouldReturn(viewControllerUnderTest.descriptionTextField))
    }
}
