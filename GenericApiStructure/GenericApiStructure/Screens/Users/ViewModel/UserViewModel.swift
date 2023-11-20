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
    var httpUtility: HttpUtility?
    var isApiResponseCame = false
    
    init(httpUtility: HttpUtility = HttpUtility()) {
        self.httpUtility = httpUtility
    }
    
    func fetchUsers() {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: AllUsers.self,
                             type: UserEndPoint.users,
                             completion: { response in
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
        httpUtility?.request(modelType: User.self,
                             type: UserEndPoint.deleteUser(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.users.remove(at: index)
                self.eventHandler?(.userDeleted)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
    
    func searchProducts(model: SearchData) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: AllUsers.self,
                             type: UserEndPoint.searchUser(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let allUsers):
                self.users = allUsers.users
                self.eventHandler?(.productSearched)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
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
