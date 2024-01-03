//
//  AddProductViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
import Combine

final class AddProductViewModel {
    var serviceManager: ServiceManagerProtocol?
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: Event = .loading
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProduct(model: DataRequestModel) {
        state = .loading
        serviceManager?.fetchProduct(type: ProductEndPoint.getProduct(model: model))
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
                state = .dataLoaded
            })
            .store(in: &cancellables)
    }
    
    func addOrUpdateProduct(type: EndPointType) {
        state = .loading
        serviceManager?.addOrUpdateProduct(type: type)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] product in
                guard let self else { return }
                state = .productAddedUpdated(product: product)
            })
            .store(in: &cancellables)
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
