//
//  HomeRouter.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

enum HomeRouter: Hashable, View {
    case home
    case productDetails(productId: Int)
    
    var body: some View {
        switch self {
        case .home:
            HomeView()
        case .productDetails(productId: let productId):
            ProductDetailsView(viewModel: ProductDetailsViewModel(useCase: ProdyctDetailsUseCase(), productId: productId))
        }
    }
}
