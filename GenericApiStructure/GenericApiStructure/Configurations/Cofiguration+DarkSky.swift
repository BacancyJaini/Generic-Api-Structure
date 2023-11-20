//
//  Cofiguration+DarkSky.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation

extension Configuration {
    enum DarkSky {
        static let apiKey: String = {
            switch Configuration.current {
            case .staging:
                return "123"
            case .production:
                return "456"
            case .dev:
                return "789"
            }
        }()
    }
}
