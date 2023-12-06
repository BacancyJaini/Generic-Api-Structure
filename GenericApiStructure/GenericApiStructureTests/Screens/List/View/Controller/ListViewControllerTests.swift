//
//  ListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

class ListViewControllerTests: XCTestCase {
    private var viewControllerUnderTest: ListViewController!
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = Storyboards.main.viewController(vc: ListViewController.self)
        viewControllerUnderTest.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        viewControllerUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(viewControllerUnderTest.listTableView)
    }
    
    func testNavTitle() {
        XCTAssertEqual(viewControllerUnderTest.navigationItem.title, "Item List")
    }
    
    func testDelegateDatasource() {
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(viewControllerUnderTest.conforms(to: UITableViewDataSource.self))
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(viewControllerUnderTest.tableView(viewControllerUnderTest.listTableView, numberOfRowsInSection: 0), Constants.listItems.count)
    }
    
    func testTableViewCellForRow() {
        let iPath0 = IndexPath(row: 0, section: 0)
        let cellRow0 = viewControllerUnderTest.tableView(viewControllerUnderTest.listTableView, cellForRowAt: iPath0)
        
        let iPath1 = IndexPath(row: 1, section: 0)
        let cellRow1 = viewControllerUnderTest.tableView(viewControllerUnderTest.listTableView, cellForRowAt: iPath1)
        
        XCTAssertEqual(cellRow0.reuseIdentifier, "cell")
        XCTAssertEqual(cellRow0.textLabel?.text, Constants.listItems[iPath0.row])
        XCTAssertEqual(cellRow1.textLabel?.text, Constants.listItems[iPath1.row])
    }
    
    func testTableViewDidSelectRow() {
        let iPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(viewControllerUnderTest.tableView(viewControllerUnderTest.listTableView, didSelectRowAt: iPath))
    }
}
