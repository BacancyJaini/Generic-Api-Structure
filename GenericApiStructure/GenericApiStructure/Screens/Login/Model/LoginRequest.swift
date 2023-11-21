//
//  Login.swift
//  GenericApiStructure
//
//  Created by user on 20/11/23.
//

import Foundation
struct LoginRequestModel: Encodable {
    let appParams: String
    let authenticationType: Int
    let deviceId: String
    let deviceType: String
    let password: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case appParams = "app_params"
        case authenticationType = "authentication_type"
        case deviceId = "device_id"
        case deviceType = "device_type"
        case username
        case password
    }
}
