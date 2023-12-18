//
//  UsersListViewController.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit

class UsersListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var usersSearchBar: UISearchBar!
    
    // MARK: - Variables
    var userViewModel: UserViewModel!
    var workItem: DispatchWorkItem?
    var serviceManager: ServiceManagerProtocol!
    
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
        observeEvent()
    }
    
    private func initViewModel() {
        userViewModel?.fetchUsers()
    }
    
    private func observeEvent() {
        userViewModel?.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
            case .dataLoaded, .userDeleted, .productSearched:
                print("Data loaded/Deleted...")
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
