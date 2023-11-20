//
//  ProductEndPoint.swift
//  API Structure
//
//  Created by user on 09/11/23.
//

import Foundation

enum ProductEndPoint {
    case products
    case getProduct(model: DataRequestModel)
    case addProduct(model: AddUpdateProduct)
    case searchProduct(model: SearchData)
    case updateProduct(model: AddUpdateProduct)
    case deleteProduct(model: DataRequestModel)
}

extension ProductEndPoint: EndPointType {

    var path: String {
        switch self {
        case .products:
            return ApiEndPoints.products
        case .addProduct:
            return ApiEndPoints.addProduct
        case .searchProduct:
            return ApiEndPoints.searchProducts
        case .getProduct(let model), .deleteProduct(let model):
            return (ApiEndPoints.products).pathWithId(id: model.id)
        case .updateProduct(let model):
            return (ApiEndPoints.products).pathWithId(id: model.id ?? Constants.kZero)
        }
    }

    var url: URL? {
        return URL(string: "\(Configuration.baseURL)\(path)")
    }

    var method: HTTPMethods {
        switch self {
        case .addProduct:
            return .post
        case .updateProduct:
            return .put
        case .deleteProduct:
            return .delete
        case .products, .getProduct, .searchProduct:
            return .get
        }
    }

    var body: Encodable? {
        switch self {
        case .addProduct(let model), .updateProduct(let model):
            return model
        case .products, .getProduct, .deleteProduct:
            return nil
        case .searchProduct(model: let model):
            return model
        }
    }

    var headers: [String : String]? {
        HttpUtility.commonHeaders
    }
}
