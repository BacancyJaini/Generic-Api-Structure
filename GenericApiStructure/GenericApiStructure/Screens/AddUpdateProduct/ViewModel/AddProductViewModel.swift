//
//  AddProductViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
final class AddProductViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProduct(model: DataRequestModel) {
        self.eventHandler?(.loading)
        serviceManager?.fetchProduct(type: ProductEndPoint.getProduct(model: model),
                                  completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func addOrUpdateProduct(type: EndPointType) {
        self.eventHandler?(.loading)
        serviceManager?.addOrUpdateProduct(type: type,
                                        completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let product):
                self.eventHandler?(.productAddedUpdated(product: product))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
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
