//
//  HttpUtility.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation
import Combine

enum DataError: Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    case decoding(Error?)
    case unknown(Error?)
}

typealias ResultHandler<T> = Future<T, DataError>

final class HttpUtility {
    
    static let shared = HttpUtility()
    private var cancellables = Set<AnyCancellable>()
    
    func request<T: Codable>(modelType: T.Type,
                             type: EndPointType) -> ResultHandler<T> {
        return ResultHandler<T> { [weak self] promise in
            guard let self = self, let url = type.url else {
                return promise(.failure(.invalidURL))
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = type.method.rawValue
            
            if let parameters = type.body, type.method == .get {
                var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
                components?.queryItems = parameters.convertToURLQueryItems()
                request.url = components?.url
            } else if let parameters = type.body {
                request.httpBody = try? JSONEncoder().encode(parameters)
            }
            
            request.allHTTPHeaderFields = type.headers
            
            // Network Request - URL TO DATA
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let response = response as? HTTPURLResponse,
                          200...299 ~= response.statusCode else {
                        throw DataError.invalidResponse
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            return promise(.failure(.decoding(decodingError)))
                        case let definedError as DataError:
                            return promise(.failure(definedError))
                        default:
                            return promise(.failure(.unknown(error)))
                        }
                    }
                } receiveValue: { return promise(.success($0)) }
                .store(in: &self.cancellables)
        }
    }
    
    static var commonHeaders: [String: String] {
        return [
            "Content-Type": "application/json"
        ]
    }
}
