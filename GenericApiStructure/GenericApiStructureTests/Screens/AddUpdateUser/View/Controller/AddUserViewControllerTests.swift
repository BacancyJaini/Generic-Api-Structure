//
//  AddUserViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddUserViewControllerTests: XCTestCase {
    private var viewControllerUnderTest: AddUserViewController!
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = Storyboards.main.viewController(vc: AddUserViewController.self)
        viewControllerUnderTest.user = "User".loadJson(ofType: User.self)
        viewControllerUnderTest.loadViewIfNeeded()
        viewControllerUnderTest.addUserViewModel = AddUserViewModel(serviceManager: MockServiceManager())
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
        XCTAssertNotNil(viewControllerUnderTest.userImageView)
        XCTAssertNotNil(viewControllerUnderTest.firstNameTextField)
        XCTAssertNotNil(viewControllerUnderTest.lastNameTextField)
        XCTAssertNotNil(viewControllerUnderTest.ageTextField)
        XCTAssertNotNil(viewControllerUnderTest.addUpdateButton)
    }
    
    func testDelegate() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITextFieldDelegate.self))
    }
    
    func testUpdateData() {
        XCTAssertEqual(viewControllerUnderTest.addUpdateButton.currentTitle, Constants.kUpdateButton)
        XCTAssertEqual(viewControllerUnderTest.firstNameTextField.text, viewControllerUnderTest.user?.firstName)
        XCTAssertEqual(viewControllerUnderTest.lastNameTextField.text, viewControllerUnderTest.user?.lastName)
        XCTAssertEqual(viewControllerUnderTest.ageTextField.text, "\(viewControllerUnderTest.user?.age ?? Constants.kZero)")
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
        XCTAssertNotNil(viewControllerUnderTest.textFieldShouldReturn(viewControllerUnderTest.firstNameTextField))
        XCTAssertNotNil(viewControllerUnderTest.textFieldShouldReturn(viewControllerUnderTest.lastNameTextField))
        XCTAssertNotNil(viewControllerUnderTest.textFieldShouldReturn(viewControllerUnderTest.ageTextField))
    }
}
