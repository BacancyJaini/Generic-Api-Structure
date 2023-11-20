//
//  Configuration.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation

enum Configuration: String {
    
    // MARK: - Configurations
    case dev
    case staging
    case production
    
    
    // MARK: - Current Configuration
    static let current: Configuration = {
        guard let rawValue = Bundle.main.infoDictionary?["Configuration"] as? String else {
            fatalError("No Configuration Found")
        }
        
        guard let configuration = Configuration(rawValue: rawValue.lowercased()) else {
            fatalError("Invalid Configuration")
        }
        
        return configuration
    }()
    
    // MARK: - Base URL
    static var baseURL: String {
        switch current {
        case .dev:
            return "https://dummyjson.com/"
        case .staging:
            return "https://staging.dummyjson.com/"
        case .production:
            return "https://prod.dummyjson.com/"
        }
    }
}
