//
//  CommonMethods.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit

class CommonMethods {
    static let shared = CommonMethods()
    private init() {}
    
    func getPathWithId(path: String, id: Int) -> String {
        return "\(path)/\(id)"
    }
}
