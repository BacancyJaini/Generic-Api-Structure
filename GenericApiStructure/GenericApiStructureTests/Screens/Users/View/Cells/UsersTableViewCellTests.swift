//
//  UsersTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class UsersTableViewCellTests: XCTestCase {
    private var cellUnderTest: UsersTableViewCell!
    
    override func setUp() {
        super.setUp()
        cellUnderTest = Bundle.main.loadNibNamed("UsersTableViewCell", owner: self, options: nil)?.first as? UsersTableViewCell
        cellUnderTest.user = "User".loadJson(ofType: User.self)
    }
    
    override func tearDown() {
        super.tearDown()
        cellUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(cellUnderTest)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(cellUnderTest.userImageView)
        XCTAssertNotNil(cellUnderTest.userBackgroundView)
        XCTAssertNotNil(cellUnderTest.firstLastNameLabel)
        XCTAssertNotNil(cellUnderTest.usernameLabel)
    }
    
    func testUserNotNil() {
        XCTAssertNotNil(cellUnderTest.user)
    }
     
    func testUserData() {
        XCTAssertEqual(cellUnderTest.firstLastNameLabel.text, "\(cellUnderTest.user?.firstName ?? Constants.kEmpty) \(cellUnderTest.user?.lastName ?? Constants.kEmpty)")
        XCTAssertEqual(cellUnderTest.usernameLabel.text, cellUnderTest.user?.username)
    }
}
