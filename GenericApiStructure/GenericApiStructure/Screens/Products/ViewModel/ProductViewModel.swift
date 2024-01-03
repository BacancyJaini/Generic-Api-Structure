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
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: Event = .loading
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProducts() {
        state = .loading
        serviceManager?.fetchProducts(type: ProductEndPoint.products)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                self.isApiResponseCame = true
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allProducts in
                guard let self else { return }
                self.initialProductsData = allProducts.products
                self.products = allProducts.products
                state = .dataLoaded
            })
            .store(in: &cancellables)
    }
    
    func deleteProduct(model: DataRequestModel, index: Int) {
        state = .loading
        serviceManager?.deleteProduct(type: ProductEndPoint.deleteProduct(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] _ in
                guard let self else { return }
                if self.products.count > index {
                    self.products.remove(at: index)
                    state = .productDeleted
                }
            })
            .store(in: &cancellables)
    }
    
    func searchProducts(model: SearchData) {
        state = .loading
        serviceManager?.searchProducts(type: ProductEndPoint.searchProduct(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allProducts in
                guard let self else { return }
                self.products = allProducts.products
                state = .productSearched
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
