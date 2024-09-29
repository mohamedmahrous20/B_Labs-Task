//
//  NetworkManager.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import UIKit
import Alamofire

final class NetworkManager: NetworkManagerProtocol {
    
    func fetchData<T: Endpoint, M: Decodable>(endPoint: T) -> ResponsePublisher<M> {
        buildRequest(endPoint: endPoint)
            .publishData()
            .tryMap {
                guard let data = $0.data else { 
                    throw NetworkError.somethingWentWrong
                }
                return data
            }
            .decode(type: M.self, decoder: JSONDecoder())
            .mapError { error in
                guard let afError = error as? AFError else {
                    return NetworkError.other(error)
                }
                
                switch afError {
                case .responseValidationFailed(reason: .unacceptableStatusCode(let statusCode)):
                    return NetworkError.httpError(statusCode)
                default:
                    return NetworkError.serverError
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func buildRequest<T: Endpoint>(endPoint: T) -> DataRequest {
        let method = Alamofire.HTTPMethod(rawValue: endPoint.method.rawValue)
        let headers = Alamofire.HTTPHeaders(endPoint.headers)
        let parameters = buildParameters(task: endPoint.task)
        return AF.request(
            endPoint.baseURL + endPoint.path,
            method: method,
            parameters: parameters.0,
            encoding: parameters.1,
            headers: headers
        )
    }
    
    private func buildParameters(task: TaskMethods) -> (Parameters, ParameterEncoding) {
        switch task {
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(let parameters, let encoding):
            return (parameters, encoding)
        }
    }
}
