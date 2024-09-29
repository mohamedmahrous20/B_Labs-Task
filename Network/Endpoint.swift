//
//  Endpoint.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HttpMethod { get}
    var task: TaskMethods { get }
    var headers: HTTPHeaders { get }
}
