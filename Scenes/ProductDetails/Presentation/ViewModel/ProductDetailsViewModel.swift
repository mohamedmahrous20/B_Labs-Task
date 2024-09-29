//
//  ProductDetailsViewModel.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 26/09/2024.
//

import Foundation

class ProductDetailsViewModel: ObservableObject {
    
    private let useCase: ProdyctDetailsUseCaseProtocol
    private let productId: Int
    
    @Published @MainActor var state: ProductDetailsState = .loading
    
    init(useCase: ProdyctDetailsUseCaseProtocol, productId: Int) {
        self.useCase = useCase
        self.productId = productId
    }
    
    func getProductDetails() async {
        await MainActor.run {
            state = .loading
        }
        
        let result = await useCase.getPrductDetails(by: productId)
        switch result {
        case .success(let data):
            await MainActor.run {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.state = .success(data)
                }
            }
        case .failure(let error):
            await MainActor.run {
                state = .error(error.localizedDescription)
            }
        }
    }
}
