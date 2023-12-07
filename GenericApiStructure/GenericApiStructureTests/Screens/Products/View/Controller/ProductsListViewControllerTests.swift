//
//  ProductsListViewControllerTests.swift
//  GenericApiStructureTests
//
//  Created by user on 20/11/23.
//

import XCTest
@testable import GenericApiStructure

final class ProductsListViewControllerTests: XCTestCase {
    private var viewControllerUnderTest: ProductsListViewController!
    private let iPath0 = IndexPath(row: 0, section: 0)
    
    override func setUp() {
        super.setUp()
        viewControllerUnderTest = Storyboards.main.viewController(vc: ProductsListViewController.self)
        viewControllerUnderTest.serviceManager = MockServiceManager()
        viewControllerUnderTest.loadViewIfNeeded()
        viewControllerUnderTest.productViewModel?.products = ("AllProduct".loadJson(ofType: AllProducts.self))?.products ?? []
    }
    
    override func tearDown() {
        super.tearDown()
        viewControllerUnderTest = nil
    }
    
    func testControllerNotNil() {
        XCTAssertNotNil(viewControllerUnderTest)
    }
    
    func testNavTitle() {
        XCTAssertEqual(viewControllerUnderTest.navigationItem.title, "Product List")
    }
    
    func testOutletsNotNil() {
        XCTAssertNotNil(viewControllerUnderTest.productsTableView)
        XCTAssertNotNil(viewControllerUnderTest.productsSearchBar)
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
            XCTAssertTrue(rightBarButtonItem.action?.description == "addProductClick:")
        }
    }
    
    func testTableViewNumberOfRows() {
        XCTAssertEqual(viewControllerUnderTest.tableView(viewControllerUnderTest.productsTableView, numberOfRowsInSection: 0), viewControllerUnderTest.productViewModel?.products.count)
    }
    
    func testTableViewCellForRow() {
        let cellRow0 = viewControllerUnderTest.tableView(viewControllerUnderTest.productsTableView, cellForRowAt: iPath0) as? ProductsTableViewCell
        
        XCTAssertEqual(cellRow0?.reuseIdentifier, "ProductsTableViewCell")
    }
    
    func testTrailingSwipeActions() {
        XCTAssertNotNil(viewControllerUnderTest.tableView(viewControllerUnderTest.productsTableView, trailingSwipeActionsConfigurationForRowAt: iPath0))
    }
    
    func testSearchBarDelegateMethods() {
        XCTAssertNotNil(viewControllerUnderTest.searchBarSearchButtonClicked(viewControllerUnderTest.productsSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarCancelButtonClicked(viewControllerUnderTest.productsSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarTextDidBeginEditing(viewControllerUnderTest.productsSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBarTextDidEndEditing(viewControllerUnderTest.productsSearchBar))
        XCTAssertNotNil(viewControllerUnderTest.searchBar(viewControllerUnderTest.productsSearchBar, textDidChange: "test"))
    }
}
