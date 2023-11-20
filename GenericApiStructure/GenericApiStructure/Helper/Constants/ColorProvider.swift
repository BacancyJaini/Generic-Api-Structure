//
//  UIColor.swift
//  API Structure
//
//  Created by user on 16/11/23.
//

import Foundation
import UIKit

protocol ColorProtocol {
    var color: UIColor? { get }
}

enum ColorProvider: String {
    case themeYellowColor = "themeYellow"
    case themeRedColor = "themeRed"
}

extension ColorProvider: ColorProtocol {
    var color: UIColor? {
        return UIColor(named: self.rawValue)
    }
}
