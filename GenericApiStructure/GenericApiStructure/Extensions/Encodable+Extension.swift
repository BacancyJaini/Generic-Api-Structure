//
//  Encodable+Extension.swift
//  API Structure
//
//  Created by user on 17/11/23.
//

import Foundation
extension Encodable {
    func convertToURLQueryItems() -> [URLQueryItem]? {
        do {
            let encoder = try JSONEncoder().encode(self)
            let requestDictionary = (try? JSONSerialization.jsonObject(with: encoder, options: .allowFragments)).flatMap{$0 as? [String: Any?]}
            if (requestDictionary != nil)  {
                var queryItems: [URLQueryItem] = []
                requestDictionary?.forEach({ (key, value) in
                    if (value != nil)  {
                        let strValue = value as? String
                        if(strValue != nil && strValue?.count != 0) {
                            queryItems.append(URLQueryItem(name: key, value: strValue))
                        }
                    }
                })
                return queryItems
            }
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}
