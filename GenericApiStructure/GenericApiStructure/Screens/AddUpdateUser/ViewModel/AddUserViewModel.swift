//
//  AddUserViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
import Combine

final class AddUserViewModel {
    var serviceManager: ServiceManagerProtocol?
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: Event = .loading
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUser(model: DataRequestModel) {
        state = .loading
        serviceManager?.fetchUser(type: UserEndPoint.getUser(model: model))
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
    
    func addOrUpdateUser(type: EndPointType) {
        state = .loading
        serviceManager?.addOrUpdateUser(type: type)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] user in
                guard let self else { return }
                state = .userAddedUpdated(user: user)
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
