//
//  UserViewModel.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import Foundation

final class UserViewModel {
    var initialUsersData: [User] = []
    var users: [User] = []
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    var isApiResponseCame = false
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUsers() {
        self.eventHandler?(.loading)
        serviceManager?.fetchUsers(type: UserEndPoint.users,
                                completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            self.isApiResponseCame = true
            switch response {
            case .success(let allUsers):
                self.initialUsersData = allUsers.users
                self.users = allUsers.users
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func deleteUser(model: DataRequestModel, index: Int) {
        self.eventHandler?(.loading)
        serviceManager?.deleteUser(type: UserEndPoint.deleteUser(model: model),
                                completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                if self.users.count > index {
                    self.users.remove(at: index)
                    self.eventHandler?(.userDeleted)
                }
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func searchUsers(model: SearchData) {
        self.eventHandler?(.loading)
        serviceManager?.searchUsers(type: UserEndPoint.searchUser(model: model),
                                 completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let allUsers):
                self.users = allUsers.users
                self.eventHandler?(.productSearched)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
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
