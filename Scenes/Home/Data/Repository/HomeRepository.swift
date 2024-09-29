//
//  HomeRepository.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getCategories() -> ResponsePublisher<[CategoriesEntity]>
    func getProducts(limit: Int, skip: Int, id: String) -> ResponsePublisher<ProductListEntity>
}

struct HomeRepository: HomeRepositoryProtocol {
    private let dataSource: HomeNetworkProtocol
    
    init(dataSource: HomeNetworkProtocol = HomeNetwork()) {
        self.dataSource = dataSource
    }
    
    func getCategories() -> ResponsePublisher<[CategoriesEntity]> {
        dataSource.getCategories()
    }

    func getProducts(limit: Int, skip: Int, id: String) -> ResponsePublisher<ProductListEntity>  {
        dataSource.getProducts(limit: limit, skip: skip, id: id)
    }
}
