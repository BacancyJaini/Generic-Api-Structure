//
//  ListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

class ListViewControllerTests: XCTestCase {
    private var sut: ListViewController!
    
    override func setUp() {
        super.setUp()
        sut = Storyboards.main.viewController(vc: ListViewController.self)
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.listTableView)
    }
    
    func testNavTitle() {
        XCTAssertEqual(sut.navigationItem.title, "Item List")
    }
    
    func testDelegateDatasource() {
        XCTAssertTrue(sut.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(sut.conforms(to: UITableViewDataSource.self))
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(sut.tableView(sut.listTableView, numberOfRowsInSection: 0), Constants.listItems.count)
    }
    
    func testTableViewCellForRow() {
        let iPath0 = IndexPath(row: 0, section: 0)
        let cellRow0 = sut.tableView(sut.listTableView, cellForRowAt: iPath0)
        
        let iPath1 = IndexPath(row: 1, section: 0)
        let cellRow1 = sut.tableView(sut.listTableView, cellForRowAt: iPath1)
        
        XCTAssertEqual(cellRow0.reuseIdentifier, "cell")
        XCTAssertEqual(cellRow0.textLabel?.text, Constants.listItems[iPath0.row])
        XCTAssertEqual(cellRow1.textLabel?.text, Constants.listItems[iPath1.row])
    }
    
    func testTableViewDidSelectRow() {
        let iPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(sut.tableView(sut.listTableView, didSelectRowAt: iPath))
    }
}
