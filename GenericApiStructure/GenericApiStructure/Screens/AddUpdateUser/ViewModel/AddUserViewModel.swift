//
//  AddUserViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
import Combine

final class AddUserViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUser(model: DataRequestModel) {
        self.eventHandler?(.loading)
        serviceManager?.fetchUser(type: UserEndPoint.getUser(model: model))
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
    
    func addOrUpdateUser(type: EndPointType) {
        self.eventHandler?(.loading)
        serviceManager?.addOrUpdateUser(type: type)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] user in
                guard let self else { return }
                self.eventHandler?(.userAddedUpdated(user: user))
            })
            .store(in: &cancellables)
    }
}

extension AddUserViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case userAddedUpdated(user: User)
    }
}
