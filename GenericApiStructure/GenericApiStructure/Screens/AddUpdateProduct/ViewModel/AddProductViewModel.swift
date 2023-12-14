//
//  AddProductViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
import Combine

final class AddProductViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchProduct(model: DataRequestModel) {
        self.eventHandler?(.loading)
        serviceManager?.fetchProduct(type: ProductEndPoint.getProduct(model: model))
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
                self.eventHandler?(.dataLoaded)
            })
            .store(in: &cancellables)
    }
    
    func addOrUpdateProduct(type: EndPointType) {
        self.eventHandler?(.loading)
        serviceManager?.addOrUpdateProduct(type: type)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] product in
                guard let self else { return }
                self.eventHandler?(.productAddedUpdated(product: product))
            })
            .store(in: &cancellables)
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
