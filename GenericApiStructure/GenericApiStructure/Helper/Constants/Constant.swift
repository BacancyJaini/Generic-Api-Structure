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
    
    static let jwtToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJleHAiOjE3MDA0NzkyMjkuNzE5MzY3LCJ1c2VyX2lkIjoiRkExMjZEODItMERFMC00QTcyLThCQzQtQzdFQkRDMUZCNjlEIn0.luRZ9nasb0cIZHchQRTyyJEjZmRDc8d2vQIaxszZo_VQdzO94jZfbrApvVB5pQp6gnJ2DGGCqcxAANyNaQLk7pc7G3FsiqGr0SB8aGXIP_mkkvF3KFBOBiFVPljHuoULdi3EpHgR46g7eSlE3dxqHWTBHep786JwMuZZ7n3ddAj417t12Jve_gNexSN8BWgDxVGrN4EAsPfbH4y1XLjtnMG2rfqNoSp5gY14jWJY_I-muigal4Wm2xtBt13xHU0VBRTJJasg8EwGYtoJNq0ZqHFb2nVMpUK5G6yMajZ5g7Hw8bJyKh2TMNNCidUgCuXm7WS0I4dpcE1icelF_1Yt2hfJxJRcDgE3ObHuYihRIrgUQ3jBXSqWN041rpvAvT_610xPSOfVC9BilrTjJWjJ6yManKgNPuwujhlL3cgb6_wQELUCVodJH--qx25IpEZqVtNKsibn4uYqukeTVqGQ_8koy1zlSZ-Y2CbhgrwJqTu9WUFryczSGEFdzt7PrUSiO9pkpymQ0Iyyf8jqYm8wnDNM8_sFIBWDXx1y6ild7mFBN3j0haus06VZfiwGGF-Pmee5N5mlgBGcmDHefRG2zVeQWEiw85swTnEgQnLtzq9F5qu2deHcbWdMQz12ZvyjKJqOT5Ktyuk4-pyPId62TyYRA3U8hFeRa9Nu6YyhtoI"
    
    static let kBearer = "Bearer "
    
    static let iosDeviceType = "iOS"
    
    static let okAlert = "Ok"
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
    
    static var login = "account/index.php?option=com_api&app=users&resource=login&format=raw"
}

struct SwipeActions {
    static var edit = "Edit"
    static var delete = "Delete"
}

struct HeaderKeys {
    static var authorization = "Authorization"
    static var contentType = "Content-Type"
}

struct HeaderContentTypes {
    static var json = "application/json"
    static var multipart = "multipart/form-data"
}
