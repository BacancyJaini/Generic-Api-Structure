//
//  AddUserViewModel.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
final class AddUserViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var serviceManager: ServiceManagerProtocol?
    
    init(serviceManager: ServiceManagerProtocol) {
        self.serviceManager = serviceManager
    }
    
    func fetchUser(model: DataRequestModel) {
        self.eventHandler?(.loading)
        serviceManager?.fetchUser(type: UserEndPoint.getUser(model: model),
                               completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
    
    func addOrUpdateUser(type: EndPointType) {
        self.eventHandler?(.loading)
        serviceManager?.addOrUpdateUser(type: type,
                                     completion: { [weak self] response in
            guard let self else { return }
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let user):
                self.eventHandler?(.userAddedUpdated(user: user))
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        })
    }
}

extension AddUserViewModel {
    func isValidData(model: AddUpdateUser) -> Bool {
        return !model.firstName.isEmpty && !model.lastName.isEmpty && model.age > 0.0
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
