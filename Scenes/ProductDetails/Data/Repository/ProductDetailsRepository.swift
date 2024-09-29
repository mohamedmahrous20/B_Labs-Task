//
//  ProductDetailsRepositoryProtocol.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol ProductDetailsRepositoryProtocol {
    func getPrductDetails(by id: Int) -> ResponsePublisher<ProductEntity>
}

struct ProductDetailsRepository: ProductDetailsRepositoryProtocol {
    private let dataSource: ProductDetailsNetworkProtocol
    
    init(dataSource: ProductDetailsNetworkProtocol = ProductDetailsNetwork()) {
        self.dataSource = dataSource
    }
    
    func getPrductDetails(by id: Int) -> ResponsePublisher<ProductEntity> {
        dataSource.getPrductDetails(by: id)
    }
}
