//
//  UsersTableViewCellTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class UsersTableViewCellTests: XCTestCase {
    private var sut: UsersTableViewCell!
    
    override func setUp() {
        super.setUp()
        sut = Bundle.main.loadNibNamed("UsersTableViewCell", owner: self, options: nil)?.first as? UsersTableViewCell
        sut.user = "User".loadJson(ofType: User.self)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.userImageView)
        XCTAssertNotNil(sut.userBackgroundView)
        XCTAssertNotNil(sut.firstLastNameLabel)
        XCTAssertNotNil(sut.usernameLabel)
    }
    
    func testUserNotNil() {
        XCTAssertNotNil(sut.user)
    }
     
    func testUserData() {
        XCTAssertEqual(sut.firstLastNameLabel.text, "\(sut.user?.firstName ?? Constants.kEmpty) \(sut.user?.lastName ?? Constants.kEmpty)")
        XCTAssertEqual(sut.usernameLabel.text, sut.user?.username)
    }
}
