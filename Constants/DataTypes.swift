//
//  DataTypes.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation
import Combine

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any]
typealias ResponsePublisher<M: Codable> = AnyPublisher<M, NetworkError>
typealias ResponseResult<M: Codable> = Result<M, NetworkError>
typealias ModelResult<M> = Result<M, NetworkError>
typealias Cancellable = Set<AnyCancellable>
