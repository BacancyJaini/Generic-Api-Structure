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
    
    func loadJson<T: Codable> (ofType: T.Type) -> T? {
        guard let jsonPath = Bundle.main.path(forResource: self, ofType: "json") else { return nil }
        do {
            guard let jsonData = try String(contentsOfFile: jsonPath).data(using: .utf8) else {
                return nil
            }
            let decodedData = try JSONDecoder().decode(ofType.self, from: jsonData)
         //   print("decodedData == ", decodedData)
            return decodedData
        } catch {
            print("parsing error ==", error)
            return nil
        }
    }
}
