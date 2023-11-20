//
//  ProductsListViewController.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var productsSearchBar: UISearchBar!
    
    // MARK: - Variables
    var productViewModel = ProductViewModel(httpUtility: HttpUtility())
    var workItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        // Do any additional setup after loading the view.
    }
}

extension ProductsListViewController {
    private func initialConfiguration() {
        productsTableView.register(UINib(nibName: "ProductsTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductsTableViewCell")
        productsTableView.register(UINib(nibName: "NoDataTableViewCell", bundle: nil), forCellReuseIdentifier: "NoDataTableViewCell")
        initViewModel()
        observeEvent()
    }
    
    private func initViewModel() {
        productViewModel.fetchProducts()
    }
    
    private func observeEvent() {
        productViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
            case .dataLoaded, .productDeleted, .productSearched:
                print("Data loaded/deleted/searched...")
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "error default")
                DispatchQueue.main.async {
                    self.productsTableView.reloadData()
                }
            }
        }
    }
    
    func resetSearchBarWithData() {
        productViewModel.products.removeAll()
        productViewModel.products.append(contentsOf: productViewModel.initialProductsData)
        DispatchQueue.main.async {
            self.productsTableView.reloadData()
        }
    }
}

// MARK: - Action
extension ProductsListViewController {
    @IBAction func addProductClick(_ sender: Any) {
        let vc = Storyboards.main.viewController(vc: AddProductViewController.self)
        vc.addUpdateProductHandler = { (product, isAddProduct) in
            // add to array
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
