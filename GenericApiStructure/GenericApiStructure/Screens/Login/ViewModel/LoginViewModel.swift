//
//  LoginViewModel.swift
//  GenericApiStructure
//
//  Created by user on 21/11/23.
//

import Foundation
final class LoginViewModel {
    var eventHandler: ((_ event: Event) -> Void)? // Data Binding Closure
    var httpUtility: HttpUtility?
    
    init(httpUtility: HttpUtility = HttpUtility()) {
        self.httpUtility = httpUtility
    }
    
    func login(model: LoginRequestModel) {
        self.eventHandler?(.loading)
        httpUtility?.request(modelType: LoginResponse.self,
                             type: LoginEndPoint.login(model: model)) { response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success:
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension LoginViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
