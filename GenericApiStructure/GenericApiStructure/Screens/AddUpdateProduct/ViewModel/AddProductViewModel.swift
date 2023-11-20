//
//  AddProductViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
final class AddProductViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var httpUtility: HttpUtility?
    
    init(httpUtility: HttpUtility = HttpUtility()) {
        self.httpUtility = httpUtility
    }
    
    func fetchProduct(model: DataRequestModel) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: Product.self,
                                   type: ProductEndPoint.getProduct(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func addOrUpdateProduct(type: EndPointType) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: Product.self,
                                   type: type) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.eventHandler?(.productAddedUpdated(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension AddProductViewModel {
    func isValidData(model: AddUpdateProduct) -> Bool {
        return !model.title.isEmpty && !model.description.isEmpty
    }
}

extension AddProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case productAddedUpdated(product: Product)
    }
}
