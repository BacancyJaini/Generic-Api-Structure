//
//  AddUserViewController.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import UIKit
import Combine

class AddUserViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    
    // MARK: - Variables
    var addUpdateUserHandler: ((_ user: User, _ isAddUser: Bool) -> Void)?
    var user: User?
    @Published private var firstName = ""
    @Published private var lastName = ""
    @Published private var age = 0
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    var addUserViewModel = AddUserViewModel(serviceManager: ServiceManager())
    private lazy var isAddNewUser: Bool = {
        return user?.id == nil
    }()
    
    private var isSubmitButtonEnabledPublisher: AnyPublisher<Bool, Never> {
        return Publishers.CombineLatest3($firstName, $lastName, $age)
            .map { firstName, lastName, age in
                !firstName.isEmpty && !lastName.isEmpty && age > 0
            }
            .eraseToAnyPublisher()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        // Do any additional setup after loading the view.
    }
}

extension AddUserViewController {
    private func initialConfiguration() {
        isSubmitButtonEnabledPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: addUpdateButton)
            .store(in: &subscriptions)
        
        userImageView.setCornerRadius(radius: userImageView.frame.size.height / 2)
      //  initViewModel()
        setupUpdateUi()
        observeEvent()
    }
    
    private func setupUpdateUi() {
        if !isAddNewUser {
            navigationItem.title = Constants.kUpdateHeader
            addUpdateButton.setTitle(Constants.kUpdateButton, for: .normal)
            userImageView.setImage(with: user?.image ?? Constants.kEmpty)
            firstNameTextField.text = user?.firstName
            firstName = user?.firstName ?? Constants.kEmpty
            lastNameTextField.text = user?.lastName
            lastName = user?.lastName ?? Constants.kEmpty
            ageTextField.text = "\(user?.age ?? Constants.kZero)"
            age = user?.age ?? Constants.kZero
        }
    }
    
    private func initViewModel() {
        if let user {
            let model = (user.id).requestModel
            addUserViewModel.fetchUser(model: model)
        }
    }
    
    private func observeEvent() {
        addUserViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator show
                print("User loading....")
            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
            case .error(let error):
                print(error ?? "error default")
            case .userAddedUpdated(let user):
                print("User added/updated...", user)
                addUpdateUserHandler?(user, isAddNewUser)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func getRequestModel() -> AddUpdateUser {
        let age = Double(ageTextField.text ?? Constants.kEmpty)
        var requestModel = AddUpdateUser(firstName: firstNameTextField.text ?? Constants.kEmpty, lastName: lastNameTextField.text ?? Constants.kEmpty, age: age ?? Constants.kZeroDouble)
        if !isAddNewUser {
            requestModel.id = user?.id
        }
        return requestModel
    }
}

// MARK: - Action
extension AddUserViewController {
    @IBAction private func addUpdateProductClick(_ sender: Any) {
        let requestModel = getRequestModel()
        
        let type = isAddNewUser ? UserEndPoint.addUser(model: requestModel) : UserEndPoint.updateUser(model: requestModel)
        addUserViewModel.addOrUpdateUser(type: type)
    }
    
    @IBAction private func textFieldTextDidChange(_ sender: UITextField) {
        switch sender.tag {
        case 100:
            firstName = sender.text ?? Constants.kEmpty
            break
        case 200:
            lastName = sender.text ?? Constants.kEmpty
            break
        case 300:
            age = Int(sender.text ?? Constants.kEmpty) ?? Constants.kZero
            break
        default:
            break
        }
    }
}

extension AddUserViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
   }
}
