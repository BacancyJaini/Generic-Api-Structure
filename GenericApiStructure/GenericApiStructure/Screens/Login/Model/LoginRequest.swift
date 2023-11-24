//
//  Login.swift
//  GenericApiStructure
//
//  Created by user on 20/11/23.
//

import Foundation
struct LoginRequestModel: Encodable {
    let device: String
    let wallpaperList: String
    let pageno: Int
    let categoryId: String
    
    enum CodingKeys: String, CodingKey {
        case device
        case wallpaperList = "wallpaper_list"
        case pageno
        case categoryId = "category_id"
    }
}
