//
//  MockHttpUtility.swift
//  GenericApiStructureTests
//
//  Created by user on 06/12/23.
//

import Foundation
@testable import GenericApiStructure

class MockServiceManager: ServiceManagerProtocol {    
    func fetchProducts(type: EndPointType, completion: @escaping (Result<AllProducts, DataError>) -> Void) {
        if let allProducts = ("AllProduct".loadJson(ofType: AllProducts.self)) {
            completion(.success(allProducts))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func deleteProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        if let product = ("Product".loadJson(ofType: Product.self)) {
            completion(.success(product))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func searchProducts(type: EndPointType, completion: @escaping (Result<AllProducts, DataError>) -> Void) {
        if let allProducts = ("AllProduct".loadJson(ofType: AllProducts.self)) {
            completion(.success(allProducts))
        }
    }
    
    func fetchProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        if let product = ("Product".loadJson(ofType: Product.self)) {
            completion(.success(product))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func addOrUpdateProduct(type: EndPointType, completion: @escaping (Result<Product, DataError>) -> Void) {
        if let product = ("Product".loadJson(ofType: Product.self)) {
            completion(.success(product))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func fetchUsers(type: EndPointType, completion: @escaping (Result<AllUsers, DataError>) -> Void) {
        if let allUsers = ("AllUsers".loadJson(ofType: AllUsers.self)) {
            completion(.success(allUsers))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func deleteUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        if let user = ("User".loadJson(ofType: User.self)) {
            completion(.success(user))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func searchUsers(type: EndPointType, completion: @escaping (Result<AllUsers, DataError>) -> Void) {
        if let allUsers = ("AllUsers".loadJson(ofType: AllUsers.self)) {
            completion(.success(allUsers))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func fetchUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        if let user = ("User".loadJson(ofType: User.self)) {
            completion(.success(user))
        } else {
            completion(.failure(.invalidData))
        }
    }
    
    func addOrUpdateUser(type: EndPointType, completion: @escaping (Result<User, DataError>) -> Void) {
        if let user = ("User".loadJson(ofType: User.self)) {
            completion(.success(user))
        } else {
            completion(.failure(.invalidData))
        }
    }
}
