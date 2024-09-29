//
//  NetworkManagerProtocol.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol NetworkManagerProtocol {
    func fetchData<T: Endpoint, M: Decodable>(endPoint: T) -> ResponsePublisher<M>
}
