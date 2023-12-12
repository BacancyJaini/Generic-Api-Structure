//
//  AddUserViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class AddUserViewControllerTests: XCTestCase {
    private var sut: AddUserViewController!
    
    override func setUp() {
        super.setUp()
        sut = Storyboards.main.viewController(vc: AddUserViewController.self)
        sut.user = "User".loadJson(ofType: User.self)
        sut.loadViewIfNeeded()
        sut.addUserViewModel = AddUserViewModel(serviceManager: MockServiceManager())
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
        XCTAssertNotNil(sut.userImageView)
        XCTAssertNotNil(sut.firstNameTextField)
        XCTAssertNotNil(sut.lastNameTextField)
        XCTAssertNotNil(sut.ageTextField)
        XCTAssertNotNil(sut.addUpdateButton)
    }
    
    func testDelegate() {
        XCTAssertTrue(sut.conforms(to: UITextFieldDelegate.self))
    }
    
    func testUpdateData() {
        XCTAssertEqual(sut.addUpdateButton.currentTitle, Constants.kUpdateButton)
        XCTAssertEqual(sut.firstNameTextField.text, sut.user?.firstName)
        XCTAssertEqual(sut.lastNameTextField.text, sut.user?.lastName)
        XCTAssertEqual(sut.ageTextField.text, "\(sut.user?.age ?? Constants.kZero)")
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
        XCTAssertNotNil(sut.textFieldShouldReturn(sut.firstNameTextField))
        XCTAssertNotNil(sut.textFieldShouldReturn(sut.lastNameTextField))
        XCTAssertNotNil(sut.textFieldShouldReturn(sut.ageTextField))
    }
}
