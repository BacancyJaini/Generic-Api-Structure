//
//  UsersListViewController.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit
import Combine

class UsersListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var usersSearchBar: UISearchBar!
    
    // MARK: - Variables
    var userViewModel: UserViewModel!
    var workItem: DispatchWorkItem?
    var serviceManager: ServiceManagerProtocol!
    private var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        // Do any additional setup after loading the view.
    }
}

extension UsersListViewController {
    private func initialConfiguration() {
        userViewModel = UserViewModel(serviceManager: serviceManager)
        usersTableView.register(UINib(nibName: "UsersTableViewCell", bundle: nil), forCellReuseIdentifier: "UsersTableViewCell")
        usersTableView.register(UINib(nibName: "NoDataTableViewCell", bundle: nil), forCellReuseIdentifier: "NoDataTableViewCell")
        initViewModel()
        cancellable = userViewModel.$state.sink { [weak self] state in
            self?.observeEvent(state)
        }
    }
    
    private func initViewModel() {
        userViewModel?.fetchUsers()
    }
    
    private func observeEvent(_ state: UserViewModel.Event) {
        switch state {
        case .loading:
            // Indicator show
            print("Product loading....")
        case .stopLoading:
            // Indicator hide
            print("Stop loading...")
        case .dataLoaded, .userDeleted, .userSearched:
            print("Data loaded/deleted/searched...")
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        case .error(let error):
            print(error ?? "error default")
            DispatchQueue.main.async {
                self.usersTableView.reloadData()
            }
        }
    }
    
    func resetSearchBarWithData() {
        userViewModel?.users.removeAll()
        userViewModel?.users.append(contentsOf: userViewModel?.initialUsersData ?? [])
        DispatchQueue.main.async {
            self.usersTableView.reloadData()
        }
    }
}

// MARK: - Action
extension UsersListViewController {
    @IBAction private func addUserClick(_ sender: Any) {
        let vc = Storyboards.main.viewController(vc: AddUserViewController.self)
        vc.addUpdateUserHandler = { (user, isAddUser) in
            // add to array
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
