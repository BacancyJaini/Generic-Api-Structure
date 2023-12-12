//
//  UsersListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class UsersListViewControllerTests: XCTestCase {
    private var sut: UsersListViewController!
    private let iPath0 = IndexPath(row: 0, section: 0)
    
    override func setUp() {
        super.setUp()
        sut = Storyboards.main.viewController(vc: UsersListViewController.self)
        sut.serviceManager = MockServiceManager()
        sut.loadViewIfNeeded()
        sut.userViewModel?.users = ("AllUsers".loadJson(ofType: AllUsers.self))?.users ?? []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testNavTitle() {
        XCTAssertEqual(sut.navigationItem.title, "User List")
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.usersTableView)
        XCTAssertNotNil(sut.usersSearchBar)
    }
    
    func testDelegateDatasource() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.conforms(to: UISearchBarDelegate.self))
    }
    
    func testAddProductIsCorrectlyAssigned() {
        if let rightBarButtonItem = sut.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(rightBarButtonItem.target)
            XCTAssert(rightBarButtonItem.target === sut)
        }
    }
    
    func testAddProductWithActionMethod() {
        if let rightBarButtonItem = sut.navigationItem.rightBarButtonItem {
            XCTAssertTrue(rightBarButtonItem.action?.description == "addUserClick:")
        }
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(sut.tableView(sut.usersTableView, numberOfRowsInSection: 0), sut.userViewModel?.users.count)
    }
    
    func testTableViewCellForRow() {
        let cellRow0 = sut.tableView(sut.usersTableView, cellForRowAt: iPath0) as? UsersTableViewCell
        
        XCTAssertEqual(cellRow0?.reuseIdentifier, "UsersTableViewCell")
    }
    
    func testTrailingSwipeActions() {
        XCTAssertNotNil(sut.tableView(sut.usersTableView, trailingSwipeActionsConfigurationForRowAt: iPath0))
    }
    
    func testSearchBarDelegateMethods() {
        XCTAssertNotNil(sut.searchBarSearchButtonClicked(sut.usersSearchBar))
        XCTAssertNotNil(sut.searchBarCancelButtonClicked(sut.usersSearchBar))
        XCTAssertNotNil(sut.searchBarTextDidBeginEditing(sut.usersSearchBar))
        XCTAssertNotNil(sut.searchBarTextDidEndEditing(sut.usersSearchBar))
        XCTAssertNotNil(sut.searchBar(sut.usersSearchBar, textDidChange: "test"))
    }
}
