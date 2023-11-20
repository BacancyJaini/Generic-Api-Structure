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
    var httpUtility: HttpUtility?
    var isApiResponseCame = false
    
    init(httpUtility: HttpUtility = HttpUtility()) {
        self.httpUtility = httpUtility
    }
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: AllProducts.self,
                                   type: ProductEndPoint.products) { response in
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
        }
    }
    
    func deleteProduct(model: DataRequestModel, index: Int) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: DeleteProductResponse.self,
                                   type: ProductEndPoint.deleteProduct(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.products.remove(at: index)
                self.eventHandler?(.productDeleted)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func searchProducts(model: SearchData) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: AllProducts.self,
                                   type: ProductEndPoint.searchProduct(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let allProducts):
                self.products = allProducts.products
                self.eventHandler?(.productSearched)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
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
