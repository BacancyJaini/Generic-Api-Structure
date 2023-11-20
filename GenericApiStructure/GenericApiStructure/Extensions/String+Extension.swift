//
//  String+Extension.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
extension String {
    func pathWithId(id: Int) -> String {
        return "\(self)/\(id)"
    }
}
