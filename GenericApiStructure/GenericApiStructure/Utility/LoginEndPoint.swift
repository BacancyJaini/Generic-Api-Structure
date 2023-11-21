//
//  LoginEndPoint.swift
//  GenericApiStructure
//
//  Created by user on 20/11/23.
//

import Foundation
enum LoginEndPoint {
    case login(model: LoginRequestModel)
}

extension LoginEndPoint: EndPointType {
    var path: String {
        switch self {
        case .login:
            return ApiEndPoints.login
        }
    }

    var url: URL? {
        return URL(string: "\(Configuration.baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .login:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .login(let model):
            return model
        }
    }

    var headers: [String : String]? {
        HttpUtility.multipartHeaders
    }
}
