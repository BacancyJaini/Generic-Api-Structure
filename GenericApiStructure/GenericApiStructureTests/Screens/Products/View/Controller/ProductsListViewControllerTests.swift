//
//  ProductsListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductsListViewControllerTests: XCTestCase {
    private var sut: ProductsListViewController!
    private let iPath0 = IndexPath(row: 0, section: 0)
        
    override func setUp() {
        super.setUp()
        sut = Storyboards.main.viewController(vc: ProductsListViewController.self)
        sut.serviceManager = MockServiceManager()
        sut.loadViewIfNeeded()
        sut.productViewModel?.products = ("AllProduct".loadJson(ofType: AllProducts.self))?.products ?? []
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testNavTitle() {
        XCTAssertEqual(sut.navigationItem.title, "Product List")
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(sut.productsTableView)
        XCTAssertNotNil(sut.productsSearchBar)
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
            XCTAssertTrue(rightBarButtonItem.action?.description == "addProductClick:")
        }
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(sut.tableView(sut.productsTableView, numberOfRowsInSection: 0), sut.productViewModel?.products.count)
    }
    
    func testTableViewCellForRow() {
        let cellRow0 = sut.tableView(sut.productsTableView, cellForRowAt: iPath0) as? ProductsTableViewCell
        
        XCTAssertEqual(cellRow0?.reuseIdentifier, "ProductsTableViewCell")
    }
    
    func testTrailingSwipeActions() {
        XCTAssertNotNil(sut.tableView(sut.productsTableView, trailingSwipeActionsConfigurationForRowAt: iPath0))
    }
    
    func testSearchBarDelegateMethods() {
        XCTAssertNotNil(sut.searchBarSearchButtonClicked(sut.productsSearchBar))
        XCTAssertNotNil(sut.searchBarCancelButtonClicked(sut.productsSearchBar))
        XCTAssertNotNil(sut.searchBarTextDidBeginEditing(sut.productsSearchBar))
        XCTAssertNotNil(sut.searchBarTextDidEndEditing(sut.productsSearchBar))
        XCTAssertNotNil(sut.searchBar(sut.productsSearchBar, textDidChange: "test"))
    }
}
