//
//  MockHttpUtility.swift
//  GenericApiStructureTests
//
//  Created by user on 06/12/23.
//

import Foundation
import Combine
@testable import GenericApiStructure

class MockServiceManager: ServiceManagerProtocol {
    func fetchProducts(type: EndPointType) -> Future<AllProducts, DataError> {
        return Future<AllProducts, DataError> { promise in
            if let allProducts = ("AllProduct".loadJson(ofType: AllProducts.self)) {
                return promise(.success(allProducts))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func deleteProduct(type: EndPointType) -> Future<Product, DataError> {
        return Future<Product, DataError> { promise in
            if let product = ("Product".loadJson(ofType: Product.self)) {
                return promise(.success(product))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func searchProducts(type: EndPointType) -> Future<AllProducts, DataError> {
        return Future<AllProducts, DataError> { promise in
            if let allProducts = ("AllProduct".loadJson(ofType: AllProducts.self)) {
                return promise(.success(allProducts))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func fetchProduct(type: EndPointType) -> Future<Product, DataError> {
        return Future<Product, DataError> { promise in
            if let product = ("Product".loadJson(ofType: Product.self)) {
                return promise(.success(product))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func addOrUpdateProduct(type: EndPointType) -> Future<Product, DataError> {
        return Future<Product, DataError> { promise in
            if let product = ("Product".loadJson(ofType: Product.self)) {
                return promise(.success(product))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func fetchUsers(type: EndPointType) -> Future<AllUsers, DataError> {
        return Future<AllUsers, DataError> { promise in
            if let allUsers = ("AllUsers".loadJson(ofType: AllUsers.self)) {
                return promise(.success(allUsers))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func deleteUser(type: EndPointType) -> Future<User, DataError> {
        return Future<User, DataError> { promise in
            if let user = ("User".loadJson(ofType: User.self)) {
                return promise(.success(user))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func searchUsers(type: EndPointType) -> Future<AllUsers, DataError> {
        return Future<AllUsers, DataError> { promise in
            if let allUsers = ("AllUsers".loadJson(ofType: AllUsers.self)) {
                return promise(.success(allUsers))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func fetchUser(type: EndPointType) -> Future<User, DataError> {
        return Future<User, DataError> { promise in
            if let user = ("User".loadJson(ofType: User.self)) {
                return promise(.success(user))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
    
    func addOrUpdateUser(type: EndPointType) -> Future<User, DataError> {
        return Future<User, DataError> { promise in
            if let user = ("User".loadJson(ofType: User.self)) {
                return promise(.success(user))
            } else {
                return promise(.failure(.invalidData))
            }
        }
    }
}
