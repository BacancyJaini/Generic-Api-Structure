//
//  ServiceManager.swift
//  GenericApiStructure
//
//  Created by user on 06/12/23.
//

import Foundation
protocol ServiceManagerProtocol {
    func fetchProducts(type: EndPointType,
                       completion: @escaping (Result<AllProducts, DataError>) -> Void)
    func deleteProduct(type: EndPointType,
                       completion: @escaping (Result<Product, DataError>) -> Void)
    func searchProducts(type: EndPointType,
                       completion: @escaping (Result<AllProducts, DataError>) -> Void)
    func fetchProduct(type: EndPointType,
                       completion: @escaping (Result<Product, DataError>) -> Void)
    func addOrUpdateProduct(type: EndPointType,
                       completion: @escaping (Result<Product, DataError>) -> Void)
    func fetchUsers(type: EndPointType,
                       completion: @escaping (Result<AllUsers, DataError>) -> Void)
    func deleteUser(type: EndPointType,
                       completion: @escaping (Result<User, DataError>) -> Void)
    func searchUsers(type: EndPointType,
                       completion: @escaping (Result<AllUsers, DataError>) -> Void)
    func fetchUser(type: EndPointType,
                       completion: @escaping (Result<User, DataError>) -> Void)
    func addOrUpdateUser(type: EndPointType,
                       completion: @escaping (Result<User, DataError>) -> Void)
}

final class ServiceManager: ServiceManagerProtocol {
    private var httpUtility = HttpUtility()
    
    func fetchUsers(type: EndPointType, completion: @escaping (Result<AllUsers, DataError>) -> Void) {
        httpUtility.request(modelType: AllUsers.self, type: type) { response in
            completion(response)
        }
    }
    
    func deleteUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        httpUtility.request(modelType: User.self, type: type) { response in
            completion(response)
        }
    }
    
    func searchUsers(type: EndPointType, completion: @escaping (Result<AllUsers, DataError>) -> Void) {
        httpUtility.request(modelType: AllUsers.self, type: type) { response in
            completion(response)
        }
    }
    
    func fetchUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        httpUtility.request(modelType: User.self, type: type) { response in
            completion(response)
        }
    }
    
    func addOrUpdateUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        httpUtility.request(modelType: User.self, type: type) { response in
            completion(response)
        }
    }
    
    func fetchProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        httpUtility.request(modelType: Product.self, type: type) { response in
            completion(response)
        }
    }
    
    func addOrUpdateProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        httpUtility.request(modelType: Product.self, type: type) { response in
            completion(response)
        }
    }
    
    func searchProducts(type: EndPointType, completion: @escaping (Result<AllProducts, DataError>) -> Void) {
        httpUtility.request(modelType: AllProducts.self, type: type) { response in
            completion(response)
        }
    }
    
    func fetchProducts(type: EndPointType, completion: @escaping (Result<AllProducts, DataError>) -> Void) {
        httpUtility.request(modelType: AllProducts.self, type: type) { response in
            completion(response)
        }
    }
    
    func deleteProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        httpUtility.request(modelType: Product.self, type: type) { response in
            completion(response)
        }
    }
}
