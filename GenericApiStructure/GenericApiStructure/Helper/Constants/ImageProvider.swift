//
//  UIImage.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
import UIKit

protocol ImageProtocol {
    var image: UIImage? { get }
}

enum ImageProvider: String {
    case sampleImage = "sample"
    case placeholderImage = "placeholder"
}

extension ImageProvider: ImageProtocol {
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
