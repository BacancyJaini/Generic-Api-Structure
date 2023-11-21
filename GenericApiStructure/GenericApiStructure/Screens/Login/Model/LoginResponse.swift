//
//  LoginResponse.swift
//  GenericApiStructure
//
//  Created by user on 20/11/23.
//

import Foundation
struct LoginResponse: Codable {
    let auth            : String?
    let code            : Int?
    let id              : String?
    let firstname       : String?
    let secondname      : String?
    let lastname        : String?
    let email           : String?
    let phone           : String?
    let jwt             : String?
    let otp             : Int?
    let otpErrorCode  : Int?
    let amount          : String?
    let otpMessages    : String?
    let otpVerification: String?
    let message         : String?
    let authLogged     : String?
    
    enum CodingKeys: String, CodingKey {
        case auth
        case code
        case id
        case firstname
        case secondname
        case lastname
        case email
        case phone
        case jwt
        case otp
        case amount
        case message
        case otpErrorCode = "otp_error_code"
        case otpMessages = "otp_messages"
        case otpVerification = "otp_verification"
        case authLogged = "auth_logged"
    }
}
