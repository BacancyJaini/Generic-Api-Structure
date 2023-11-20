//
//  Constant.swift
//  API Structure
//
//  Created by user on 08/11/23.
//

import UIKit

class Constants {
    static var listItems = ["Products", "Users"]
    static let kEmpty = ""
    static let kZero = 0
    static let kZeroDouble = 0.0
    static let kCurrency = "$"
    
    static let kUpdateHeader = "Update Product"
    static let kUpdateButton = "Update"
    
    static let kNoData = "No Data Found!!!"
}

enum Storyboards: String {
    case main = "Main"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T>(vc : T.Type) -> T where T: UIViewController {
        let identifier = String(describing: T.self)
        return self.instance.instantiateViewController(withIdentifier: identifier) as! T
    }
}

struct ApiEndPoints {
    static var products = "products"
    static var addProduct = "products/add"
    static var searchProducts = "products/search"
    
    static var users = "users"
    static var addUser = "users/add"
    static var searchUsers = "users/search"
}

struct SwipeActions {
    static var edit = "Edit"
    static var delete = "Delete"
}
