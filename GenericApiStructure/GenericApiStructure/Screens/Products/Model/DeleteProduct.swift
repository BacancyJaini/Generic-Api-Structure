//
//  DeleteProduct.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation

struct DeleteProductResponse: Codable {
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category, thumbnail: String
    let images: [String]
    let isDeleted: Bool
    let deletedOn: String
}
