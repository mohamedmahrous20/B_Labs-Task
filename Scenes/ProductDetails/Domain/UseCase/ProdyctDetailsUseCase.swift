//
//  HomeUseCase.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

protocol ProdyctDetailsUseCaseProtocol: AnyObject {
    func getPrductDetails(by id: Int) async -> ModelResult<ProductEntity>
}

class ProdyctDetailsUseCase: ProdyctDetailsUseCaseProtocol {
    private let repository: ProductDetailsRepositoryProtocol
    private var cancllable = Cancellable()
    
    init(repository: ProductDetailsRepositoryProtocol = ProductDetailsRepository()) {
        self.repository = repository
    }
    
    func getPrductDetails(by id: Int) async -> ModelResult<ProductEntity> {
        await repository.getPrductDetails(by: id)
            .singleOutput(with: &cancllable)
    }
}
