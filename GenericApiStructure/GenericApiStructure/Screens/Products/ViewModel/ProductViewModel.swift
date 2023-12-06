//
//  ProductViewModel.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import Foundation

final class ProductViewModel {
    var initialProductsData: [Product] = []
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        serviceManager?.fetchProducts(type: ProductEndPoint.products,
                                         completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            self.isApiResponseCame = true
            switch response {
            case .success(let allProducts):
                self.initialProductsData = allProducts.products
                self.products = allProducts.products
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func deleteProduct(model: DataRequestModel, index: Int) {
        self.eventHandler?(.loading)
        serviceManager?.deleteProduct(type: ProductEndPoint.deleteProduct(model: model),
                                   completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                if self.products.count > index {
                    self.products.remove(at: index)
                    self.eventHandler?(.productDeleted)
                }
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func searchProducts(model: SearchData) {
        self.eventHandler?(.loading)
        serviceManager?.searchProducts(type: ProductEndPoint.searchProduct(model: model), 
                                    completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let allProducts):
                self.products = allProducts.products
                self.eventHandler?(.productSearched)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
}

extension ProductViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case productDeleted
        case productSearched
    }
}
