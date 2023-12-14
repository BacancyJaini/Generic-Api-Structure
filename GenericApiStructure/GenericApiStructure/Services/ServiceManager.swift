//
//  ServiceManager.swift
//  GenericApiStructure
//
//  Created by user on 06/12/23.
//

import Foundation
import Combine

protocol ServiceManagerProtocol {
    func fetchProducts(type: EndPointType) -> Future<AllProducts, DataError>
    func deleteProduct(type: EndPointType) -> Future<Product, DataError>
    func searchProducts(type: EndPointType) -> Future<AllProducts, DataError>
    func fetchProduct(type: EndPointType) -> Future<Product, DataError>
    func addOrUpdateProduct(type: EndPointType) -> Future<Product, DataError>
    func fetchUsers(type: EndPointType) -> Future<AllUsers, DataError>
    func deleteUser(type: EndPointType) -> Future<User, DataError>
    func searchUsers(type: EndPointType) -> Future<AllUsers, DataError>
    func fetchUser(type: EndPointType) -> Future<User, DataError>
    func addOrUpdateUser(type: EndPointType) -> Future<User, DataError>
}

final class ServiceManager: ServiceManagerProtocol {
    private var httpUtility = HttpUtility()
    
    func fetchProducts(type: EndPointType) -> Future<AllProducts, DataError> {
        return httpUtility.request(modelType: AllProducts.self, type: type)
    }
    
    func deleteProduct(type: EndPointType) -> Future<Product, DataError> {
        return httpUtility.request(modelType: Product.self, type: type)
    }
    
    func searchProducts(type: EndPointType) -> Future<AllProducts, DataError> {
        return httpUtility.request(modelType: AllProducts.self, type: type)
    }
    
    func fetchProduct(type: EndPointType) -> Future<Product, DataError> {
        return httpUtility.request(modelType: Product.self, type: type)
    }
    
    func addOrUpdateProduct(type: EndPointType) -> Future<Product, DataError> {
        return httpUtility.request(modelType: Product.self, type: type)
    }
    
    func fetchUsers(type: EndPointType) -> Future<AllUsers, DataError> {
        return httpUtility.request(modelType: AllUsers.self, type: type)
    }
    
    func deleteUser(type: EndPointType) -> Future<User, DataError> {
        return httpUtility.request(modelType: User.self, type: type)
    }
    
    func searchUsers(type: EndPointType) -> Future<AllUsers, DataError> {
        return httpUtility.request(modelType: AllUsers.self, type: type)
    }
    
    func fetchUser(type: EndPointType) -> Future<User, DataError> {
        return httpUtility.request(modelType: User.self, type: type)
    }
    
    func addOrUpdateUser(type: EndPointType) -> Future<User, DataError> {
        return httpUtility.request(modelType: User.self, type: type)
    }
}
