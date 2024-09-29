//
//  ProductDetailsNetwork.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol ProductDetailsNetworkProtocol {
    func getPrductDetails(by id: Int) -> ResponsePublisher<ProductEntity>
}

struct ProductDetailsNetwork: ProductDetailsNetworkProtocol {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    func getPrductDetails(by id: Int) -> ResponsePublisher<ProductEntity> {
        network.fetchData(endPoint: ProductEndPoint.productDetails(id: id))
    }
}
