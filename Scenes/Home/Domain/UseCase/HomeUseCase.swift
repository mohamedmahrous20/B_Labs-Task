//
//  HomeUseCase.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol HomeUseCaseProtocol: AnyObject {
    func getCategories() async -> ModelResult<[CategoryScreenData]>
    func getProducts(limit: Int, skip: Int, id: String) async -> ModelResult<ProductListEntity>
}

class HomeUseCase: HomeUseCaseProtocol {
    private let repository: HomeRepositoryProtocol
    private var cancllable = Cancellable()
    
    init(repository: HomeRepositoryProtocol = HomeRepository()) {
        self.repository = repository
    }
    
    func getCategories() async -> ModelResult<[CategoryScreenData]> {
       let result = await repository
            .getCategories()
            .singleOutput(with: &cancllable)
        
        switch result {
        case .success(let categories):
            return .success(categories.map({ CategoryScreenData(category: $0) }).compactMap({ $0 }))
        case .failure(let error):
            return .failure(error)
        }
    }

    func getProducts(limit: Int, skip: Int, id: String) async -> ModelResult<ProductListEntity> {
        await repository.getProducts(limit: limit, skip: skip, id: id)
            .singleOutput(with: &cancllable)
    }
}
