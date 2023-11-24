//
//  HttpUtility.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
}

typealias ResultHandler<T> = (Result<T, DataError>) -> Void

final class HttpUtility {
    
    static let shared = HttpUtility()
    private let networkHandler: NetworkHandler
    private let responseHandler: ResponseHandler
    
    init(networkHandler: NetworkHandler = NetworkHandler(),
         responseHandler: ResponseHandler = ResponseHandler()) {
        self.networkHandler = networkHandler
        self.responseHandler = responseHandler
    }
    
    func request<T: Codable>(modelType: T.Type,
                           //  model: LoginRequestModel? = nil,
                             type: EndPointType,
                             completion: @escaping ResultHandler<T>) {
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = type.method.rawValue
        
        if let parameters = type.body, type.method == .get {
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters.convertToURLQueryItems()
            request.url = components?.url
        } else if let parameters = type.body {
            request.httpBody = try? JSONEncoder().encode(parameters)
//            let contents = String(data: request.httpBody!, encoding: .utf8)
//            print("req ==", contents!)
        }
        
        /*let lineBreak = "\r\n"
        
        let boundary = "---------------------------------\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "content-type")
        
        var requestData = Data()
        
        requestData.append("--\(boundary)\r\n" .data(using: .utf8)!)
        requestData.append("content-disposition: form-data; name=\"device\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append(model!.device .data(using: .utf8)!)
        
        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
        requestData.append("content-disposition: form-data; name=\"category_id\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append("\(model!.categoryId + lineBreak)" .data(using: .utf8)!)
        
        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
        requestData.append("content-disposition: form-data; name=\"wallpaper_list\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append("\(model!.wallpaperList + lineBreak)" .data(using: .utf8)!)
        
        requestData.append("\(lineBreak)--\(boundary)\r\n" .data(using: .utf8)!)
        requestData.append("content-disposition: form-data; name=\"pageno\" \(lineBreak + lineBreak)" .data(using: .utf8)!)
        requestData.append("\("\(model?.pageno ?? 1)" + lineBreak)" .data(using: .utf8)!)
        
        requestData.append("--\(boundary)--\(lineBreak)" .data(using: .utf8)!)
        
        request.addValue("\(requestData.count)", forHTTPHeaderField: "content-length")
        request.httpBody = requestData
        
        let multipartStr = String(decoding: requestData, as: UTF8.self) //to view the multipart form string
        print("new req ==", multipartStr)*/
        
        request.allHTTPHeaderFields = type.headers
        
        // Network Request - URL TO DATA
        networkHandler.requestDataAPI(url: request) { result in
            switch result {
            case .success(let data):
                // Json parsing - Decoder - DATA TO MODEL
//                let contents = String(data: data, encoding: .utf8) //to view the response string
//                print("res ==", contents!)
                self.responseHandler.parseResonseDecode(
                    data: data,
                    modelType: modelType) { response in
                        switch response {
                        case .success(let mainResponse):
                            completion(.success(mainResponse))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static var commonHeaders: [String: String] {
        return [
            HeaderKeys.contentType: HeaderContentTypes.json
        ]
    }
    
    static var multipartHeaders: [String: String] {
        return [
            HeaderKeys.authorization: Constants.kBearer + Constants.jwtToken,
            HeaderKeys.contentType: HeaderContentTypes.multipart
        ]
    }
}

class NetworkHandler {
    func requestDataAPI(
        url: URLRequest,
        completionHandler: @escaping (Result<Data, DataError>) -> Void
    ) {
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            
            guard let data, error == nil else {
                completionHandler(.failure(.invalidData))
                return
            }
            
            completionHandler(.success(data))
        }
        session.resume()
    }
}

class ResponseHandler {
    func parseResonseDecode<T: Decodable>(
        data: Data,
        modelType: T.Type,
        completionHandler: ResultHandler<T>
    ) {
        do {
            let userResponse = try JSONDecoder().decode(modelType, from: data)
            completionHandler(.success(userResponse))
        } catch {
            completionHandler(.failure(.decoding(error)))
        }
    }
}
