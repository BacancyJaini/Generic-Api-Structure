//
//  LoginViewController.swift
//  GenericApiStructure
//
//  Created by user on 21/11/23.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    // MARK: - Variables
    var loginViewModel = LoginViewModel(httpUtility: HttpUtility())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeEvent()
        // Do any additional setup after loading the view.
    }
}

extension LoginViewController {
    private func getLoginRequest() -> LoginRequestModel {
        return LoginRequestModel(device: "portrait", wallpaperList: "all", pageno: 1, categoryId: "34")
    }
}

extension LoginViewController {
    private func observeEvent() {
        loginViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded")
                DispatchQueue.main.async {
                    let vc = Storyboards.main.viewController(vc: ListViewController.self)
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .error(let error):
                print(error ?? "error default")
                DispatchQueue.main.async {
                    let okAction = UIAlertAction(title: Constants.okAlert, style: .cancel, handler: nil)
                    self.show(message: error?.localizedDescription ?? Constants.kEmpty, actions: [okAction])
                }
            }
        }
    }
}

// MARK: - Action
extension LoginViewController {
    @IBAction func loginClick(_ sender: Any) {
        let model = getLoginRequest()
        loginViewModel.login(model: model)
    }
}
