//
//  Int+Extension.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
extension Int {
    var requestModel: DataRequestModel {
        return DataRequestModel(id: self)
    }
    
    var priceWithCurrency: String {
        return "\(Constants.kCurrency)\(self)"
    }
}
