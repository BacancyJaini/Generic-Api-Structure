//
//  AddUser.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
struct AddUpdateUser: Encodable {
    var id: Int? = nil
    let firstName: String
    let lastName: String
    let age: Double
}
