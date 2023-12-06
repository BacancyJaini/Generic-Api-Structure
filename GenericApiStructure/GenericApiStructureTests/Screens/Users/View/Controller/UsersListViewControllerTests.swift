//
//  UsersListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class UsersListViewControllerTests: XCTestCase {
    private var viewControllerUnderTest: UsersListViewController!
    private let iPath0 = IndexPath(row: 0, section: 0)
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = Storyboards.main.viewController(vc: UsersListViewController.self)
        viewControllerUnderTest.loadViewIfNeeded()
        viewControllerUnderTest.userViewModel = UserViewModel(serviceManager: MockServiceManager())
        viewControllerUnderTest.userViewModel.users = ("AllUsers".loadJson(ofType: AllUsers.self))?.users ?? []
    }
    
    override func tearDown() {
        super.tearDown()
        viewControllerUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testNavTitle() {
        XCTAssertEqual(viewControllerUnderTest.navigationItem.title, "User List")
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(viewControllerUnderTest.usersTableView)
        XCTAssertNotNil(viewControllerUnderTest.usersSearchBar)
    }
    
    func testDelegateDatasource() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UISearchBarDelegate.self))
    }
    
    func testAddProductIsCorrectlyAssigned() {
        if let rightBarButtonItem = viewControllerUnderTest.navigationItem.rightBarButtonItem {
            XCTAssertNotNil(rightBarButtonItem.target)
            XCTAssert(rightBarButtonItem.target === viewControllerUnderTest)
        }
    }
    
    func testAddProductWithActionMethod() {
        if let rightBarButtonItem = viewControllerUnderTest.navigationItem.rightBarButtonItem {
            XCTAssertTrue(rightBarButtonItem.action?.description == "addUserClick:")
        }
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(viewControllerUnderTest.tableView(viewControllerUnderTest.usersTableView, numberOfRowsInSection: 0), viewControllerUnderTest.userViewModel.users.count)
    }
    
    func testTableViewCellForRow() {
        let cellRow0 = viewControllerUnderTest.tableView(viewControllerUnderTest.usersTableView, cellForRowAt: iPath0) as? UsersTableViewCell
        
        XCTAssertEqual(cellRow0?.reuseIdentifier, "UsersTableViewCell")
    }
    
    func testTrailingSwipeActions() {
        XCTAssertNotNil(viewControllerUnderTest.tableView(viewControllerUnderTest.usersTableView, trailingSwipeActionsConfigurationForRowAt: iPath0))
    }
    
    func testSearchBarDelegateMethods() {
        XCTAssertNotNil(viewControllerUnderTest.searchBarSearchButtonClicked(viewControllerUnderTest.usersSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarCancelButtonClicked(viewControllerUnderTest.usersSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarTextDidBeginEditing(viewControllerUnderTest.usersSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarTextDidEndEditing(viewControllerUnderTest.usersSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBar(viewControllerUnderTest.usersSearchBar, textDidChange: "test"))
    }
}
