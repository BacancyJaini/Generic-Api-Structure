//
//  UserViewModel.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import Foundation
import Combine

final class UserViewModel {
    var initialUsersData: [User] = []
    var users: [User] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    private var cancellables = Set<AnyCancellable>()
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUsers() {
        self.eventHandler?(.loading)
        serviceManager?.fetchUsers(type: UserEndPoint.users)
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
            }, receiveValue: { [weak self] allUsers in
                guard let self else { return }
                self.initialUsersData = allUsers.users
                self.users = allUsers.users
                self.eventHandler?(.dataLoaded)
            })
            .store(in: &cancellables)
    }
    
    func deleteUser(model: DataRequestModel, index: Int) {
        self.eventHandler?(.loading)
        serviceManager?.deleteUser(type: UserEndPoint.deleteUser(model: model))
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
                if self.users.count > index {
                    self.users.remove(at: index)
                    self.eventHandler?(.userDeleted)
                }
            })
            .store(in: &cancellables)
    }
    
    func searchUsers(model: SearchData) {
        self.eventHandler?(.loading)
        serviceManager?.searchUsers(type: UserEndPoint.searchUser(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                self.eventHandler?(.stopLoading)
                switch completion {
                case .failure(let error):
                    self.eventHandler?(.error(error))
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allUsers in
                guard let self else { return }
                self.users = allUsers.users
                self.eventHandler?(.productSearched)
            })
            .store(in: &cancellables)
    }
}

extension UserViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
        case userDeleted
        case productSearched
    }
}
