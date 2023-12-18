//
//  ListViewController.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit

class ListViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet private weak var listTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

// MARK: - UITableView Delegate & DataSource
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = Constants.listItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController?
        switch indexPath.row {
        case 1:
            vc = Storyboards.main.viewController(vc: UsersListViewController.self)
            (vc as! UsersListViewController).serviceManager = ServiceManager()
        default:
            vc = Storyboards.main.viewController(vc: ProductsListViewController.self)
            (vc as! ProductsListViewController).serviceManager = ServiceManager()
        }
        navigationController?.pushViewController(vc!, animated: true)
    }
}
