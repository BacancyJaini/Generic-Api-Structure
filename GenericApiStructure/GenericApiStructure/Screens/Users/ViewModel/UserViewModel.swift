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
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    private var cancellables = Set<AnyCancellable>()
    @Published private(set) var state: Event = .loading
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUsers() {
        state = .loading
        serviceManager?.fetchUsers(type: UserEndPoint.users)
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
            }, receiveValue: { [weak self] allUsers in
                guard let self else { return }
                self.initialUsersData = allUsers.users
                self.users = allUsers.users
                state = .dataLoaded
            })
            .store(in: &cancellables)
    }
    
    func deleteUser(model: DataRequestModel, index: Int) {
        state = .loading
        serviceManager?.deleteUser(type: UserEndPoint.deleteUser(model: model))
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
                if self.users.count > index {
                    self.users.remove(at: index)
                    state = .userDeleted
                }
            })
            .store(in: &cancellables)
    }
    
    func searchUsers(model: SearchData) {
        state = .loading
        serviceManager?.searchUsers(type: UserEndPoint.searchUser(model: model))
            .sink(receiveCompletion: { [weak self] completion in
                guard let self else { return }
                state = .stopLoading
                switch completion {
                case .failure(let error):
                    state = .error(error)
                case .finished:
                    print("Finished")
                }
            }, receiveValue: { [weak self] allUsers in
                guard let self else { return }
                self.users = allUsers.users
                state = .userSearched
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
        case userSearched
    }
}
