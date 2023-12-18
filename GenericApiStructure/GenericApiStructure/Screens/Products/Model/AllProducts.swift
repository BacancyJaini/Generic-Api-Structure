//
//  Product.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation

struct AllProducts: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable {
    let id: Int
    var title, description: String
    let price: Int?
    let discountPercentage, rating: Double?
    let stock: Int?
    let brand, category, thumbnail: String?
    let images: [String]?
}

struct Rate: Codable {
    let rate: Double
    let count: Int
}
