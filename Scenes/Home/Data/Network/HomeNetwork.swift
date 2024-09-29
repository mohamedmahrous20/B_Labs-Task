//
//  HomeNetwork.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol HomeNetworkProtocol {
    func getCategories() -> ResponsePublisher<[CategoriesEntity]>
    func getProducts(limit: Int, skip: Int, id: String) -> ResponsePublisher<ProductListEntity>
}

struct HomeNetwork: HomeNetworkProtocol {
    
    private let network: NetworkManagerProtocol
    
    init(network: NetworkManagerProtocol = NetworkManager()) {
        self.network = network
    }
    
    func getCategories() -> ResponsePublisher<[CategoriesEntity]> {
        network.fetchData(endPoint: ProductEndPoint.getCategories)
    }

    func getProducts(limit: Int, skip: Int, id: String) -> ResponsePublisher<ProductListEntity> {
        network.fetchData(endPoint: ProductEndPoint.getProducts(limit: limit, skip: skip, categroyID: id))
    }
}
