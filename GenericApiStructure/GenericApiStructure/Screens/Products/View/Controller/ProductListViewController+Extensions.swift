//
//  ProductListViewController+UITableView.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
import UIKit

extension ProductsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productViewModel.products.isEmpty && productViewModel.isApiResponseCame ? 1 : productViewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if productViewModel.products.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataTableViewCell") as? NoDataTableViewCell else {
                return UITableViewCell()
            }
            cell.noDataLabel.text = Constants.kNoData
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell") as? ProductsTableViewCell else {
                return UITableViewCell()
            }
            cell.product = productViewModel.products[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !productViewModel.products.isEmpty {
            let product = productViewModel.products[indexPath.row]
            
            let editAction = UIContextualAction(style: .normal, title: SwipeActions.edit) { _, _, _ in
                let vc = Storyboards.main.viewController(vc: AddProductViewController.self)
                vc.product = product
                vc.addUpdateProductHandler = { (product, isAddProduct) in
                    //update product in an array
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            editAction.backgroundColor = ColorProvider.themeYellowColor.color
            
            let deleteAction = UIContextualAction(style: .normal, title: SwipeActions.delete) { _, _, _ in
                let requestModel = (product.id).requestModel
                self.productViewModel.deleteProduct(model: requestModel, index: indexPath.row)
            }
            deleteAction.backgroundColor = ColorProvider.themeRedColor.color
            
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            return swipeActions
        }
        return nil
    }
}

extension ProductsListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = Constants.kEmpty
        resetSearchBarWithData()
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        workItem?.cancel()
        if searchText.isEmpty {
            resetSearchBarWithData()
        } else {
            let workItem = DispatchWorkItem { [weak self] in
                guard let self else { return }
                let requestModel = SearchData(q: searchText)
                self.productViewModel.searchProducts(model: requestModel)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: workItem)
            self.workItem = workItem
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
}
