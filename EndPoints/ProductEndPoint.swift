//
//  ProductEndPoint.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Alamofire

enum ProductEndPoint {
    case getCategories
    case getProducts(limit: Int = 10,  skip: Int = 0, categroyID: String?)
    case productDetails(id: Int)
}

extension ProductEndPoint: Endpoint {
    var baseURL: String {
        Constants.baseURL
    }
    
    var path: String {
        let completePath = switch self {
        case .getCategories:
            "/categories"
        case .getProducts(let limit, let skip, let categroyID):
            categroyID == nil ? "?limit=\(limit)&skip=\(skip)" : "/category/\(categroyID ?? "")"
        case .productDetails(let id):
            "/\(id)"
        }
        return "products\(completePath)"
    }
    
    var method: HttpMethod {
        .GET
    }
    
    var task: TaskMethods {
        .requestPlain
    }
    
    var headers: HTTPHeaders {
        [:]
    }
}
