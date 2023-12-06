//
//  AddProductViewController.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import UIKit

class AddProductViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var addUpdateButton: UIButton!
    
    // MARK: - Variables
    var addUpdateProductHandler: ((_ product: Product, _ isAddProduct: Bool) -> Void)?
    var product: Product?
    var addProductViewModel = AddProductViewModel(serviceManager: ServiceManager())
    private lazy var isAddNewProduct: Bool = {
        return product?.id == nil
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfiguration()
        // Do any additional setup after loading the view.
    }
}

extension AddProductViewController {
    private func initialConfiguration() {
        productImageView.setCornerRadius(radius: productImageView.frame.size.height / 2)
      //  initViewModel()
        setupUpdateUi()
        observeEvent()
    }
    
    func setupUpdateUi() {
        if !isAddNewProduct {
            navigationItem.title = Constants.kUpdateHeader
            addUpdateButton.setTitle(Constants.kUpdateButton, for: .normal)
            productImageView.setImage(with: product?.thumbnail ?? Constants.kEmpty)
            titleTextField.text = product?.title
            descriptionTextField.text = product?.description
        }
    }
    
    private func initViewModel() {
        if let product {
            let model = (product.id).requestModel
            addProductViewModel.fetchProduct(model: model)
        }
    }
    
    private func observeEvent() {
        addProductViewModel.eventHandler = { [weak self] event in
            guard let self else { return }
            switch event {
            case .loading:
                // Indicator show
                print("Product loading....")
            case .stopLoading:
                // Indicator hide
                print("Stop loading...")
            case .dataLoaded:
                print("Data loaded...")
            case .error(let error):
                print(error ?? "error default")
            case .productAddedUpdated(let product):
                print("Product added/updated...", product)
                addUpdateProductHandler?(product, isAddNewProduct)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func getRequestModel() -> AddUpdateProduct {
        var requestModel = AddUpdateProduct(title: titleTextField.text ?? Constants.kEmpty, description: descriptionTextField.text ?? Constants.kEmpty)
        if !isAddNewProduct {
            requestModel.id = product?.id
        }
        return requestModel
    }
}

// MARK: - Action
extension AddProductViewController {
    @IBAction func addUpdateProductClick(_ sender: Any) {
        let requestModel = getRequestModel()
        
        if (addProductViewModel.isValidData(model: requestModel)) {
            let type = isAddNewProduct ? ProductEndPoint.addProduct(model: requestModel) : ProductEndPoint.updateProduct(model: requestModel)
            addProductViewModel.addOrUpdateProduct(type: type)
        }
    }
}

extension AddProductViewController: UITextFieldDelegate {
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      textField.resignFirstResponder()
   }
}
