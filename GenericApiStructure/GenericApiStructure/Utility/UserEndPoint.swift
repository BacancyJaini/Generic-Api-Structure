//
//  UserEndPoint.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
enum UserEndPoint {
    case users
    case getUser(model: DataRequestModel)
    case addUser(model: AddUpdateUser)
    case searchUser(model: SearchData)
    case updateUser(model: AddUpdateUser)
    case deleteUser(model: DataRequestModel)
}

extension UserEndPoint: EndPointType {

    var path: String {
        switch self {
        case .users:
            return ApiEndPoints.users
        case .addUser:
            return ApiEndPoints.addUser
        case .searchUser:
            return ApiEndPoints.searchUsers
        case .getUser(let model), .deleteUser(let model):
            return (ApiEndPoints.users).pathWithId(id: model.id)
        case .updateUser(let user):
            return (ApiEndPoints.users).pathWithId(id: user.id ?? 0)
        }
    }

    var url: URL? {
        return URL(string: "\(Configuration.baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .addUser:
            return .post
        case .updateUser:
            return .put
        case .deleteUser:
            return .delete
        case .users, .getUser, .searchUser:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .addUser(let model), .updateUser(let model):
            return model
        case .users, .getUser, .deleteUser:
            return nil
        case .searchUser(let model):
            return model
        }
    }

    var headers: [String : String]? {
        HttpUtility.commonHeaders
    }
}
