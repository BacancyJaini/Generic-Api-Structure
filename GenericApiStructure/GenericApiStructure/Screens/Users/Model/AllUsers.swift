//
//  AllUsers.swift
//  API Structure
//
//  Created by user on 10/11/23.
//

import Foundation

// MARK: - Welcome
struct AllUsers: Codable {
    let users: [User]
    let total, skip, limit: Int
}

// MARK: - User
struct User: Codable {
    let id: Int
    let firstName, lastName, maidenName: String
    let age: Int
    let gender, email, phone, username: String
    let password, birthDate: String
    let image: String
    let bloodGroup: String
    let height: Int?
    let weight: Double?
    let eyeColor: String
    let hair: Hair
    let domain, ip: String
    let address: Address?
    let macAddress, university: String
    let bank: Bank
    let company: Company
    let ein, ssn, userAgent: String
}

// MARK: - Address
struct Address: Codable {
    let address, city: String?
    let coordinates: Coordinates?
    let postalCode, state: String
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let lat, lng: Double?
}

// MARK: - Bank
struct Bank: Codable {
    let cardExpire, cardNumber, cardType, currency: String
    let iban: String
}

// MARK: - Company
struct Company: Codable {
    let address: Address?
    let department, name, title: String
}

// MARK: - Hair
struct Hair: Codable {
    let color, type: String
}
