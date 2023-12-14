//
//  ProductViewModel.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import Foundation
import Combine

final class ProductViewModel {
    var initialProductsData: [Product] = []
    var products: [Product] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProducts() {
        self.eventHandler?(.loading)
        serviceManager?.fetchProducts(type: ProductEndPoint.products)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                self.isApiResponseCame = true
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allProducts in
                guard let self else { return }
                self.initialProductsData = allProducts.products
                self.products = allProducts.products
                self.eventHandler?(.dataLoaded)
            })
            .store(in: &cancellables)
    }
    
    func deleteProduct(model: DataRequestModel, index: Int) {
        self.eventHandler?(.loading)
        serviceManager?.deleteProduct(type: ProductEndPoint.deleteProduct(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] _ in
                guard let self else { return }
                if self.products.count > index {
                    self.products.remove(at: index)
                    self.eventHandler?(.productDeleted)
                }
            })
            .store(in: &cancellables)
    }
    
    func searchProducts(model: SearchData) {
        self.eventHandler?(.loading)
        serviceManager?.searchProducts(type: ProductEndPoint.searchProduct(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allProducts in
                guard let self else { return }
                self.products = allProducts.products
                self.eventHandler?(.productSearched)
            })
            .store(in: &cancellables)
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
