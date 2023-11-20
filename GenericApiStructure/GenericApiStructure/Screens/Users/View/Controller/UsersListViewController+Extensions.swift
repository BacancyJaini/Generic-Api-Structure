//
//  UsersListViewController+UITableView.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
import UIKit

extension UsersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userViewModel.users.isEmpty && userViewModel.isApiResponseCame ? 1 : userViewModel.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if userViewModel.users.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NoDataTableViewCell") as? NoDataTableViewCell else {
                return UITableViewCell()
            }
            cell.noDataLabel.text = Constants.kNoData
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell else {
                return UITableViewCell()
            }
            cell.user = userViewModel.users[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if !userViewModel.users.isEmpty {
            let user = userViewModel.users[indexPath.row]
            let editAction = UIContextualAction(style: .normal, title: SwipeActions.edit) { _, _, _ in
                let vc = Storyboards.main.viewController(vc: AddUserViewController.self)
                vc.user = user
                vc.addUpdateUserHandler = { (user, isAddUser) in
                    //update product in an array
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            editAction.backgroundColor = ColorProvider.themeYellowColor.color
            
            let deleteAction = UIContextualAction(style: .normal, title: SwipeActions.delete) { _, _, _ in
                let requestModel = (user.id).requestModel
                self.userViewModel.deleteUser(model: requestModel, index: indexPath.row)
            }
            deleteAction.backgroundColor = ColorProvider.themeRedColor.color
            
            let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
            return swipeActions
        }
        return nil
    }
}

extension UsersListViewController: UISearchBarDelegate {
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
                self.userViewModel.searchProducts(model: requestModel)
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
