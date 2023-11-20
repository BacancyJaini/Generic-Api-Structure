//
//  AddUpdateProduct.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
struct AddUpdateProduct: Encodable {
    var id: Int? = nil
    let title, description: String
}
