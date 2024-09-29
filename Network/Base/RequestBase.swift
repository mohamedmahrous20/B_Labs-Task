//
//  RequestBase.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Alamofire

enum HttpMethod: String {
    case GET
    case POST
}

enum TaskMethods {
    case requestPlain
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
}
