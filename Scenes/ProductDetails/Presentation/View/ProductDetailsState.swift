//
//  ProductDetailsState.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 26/09/2024.
//

import Foundation

enum ProductDetailsState: Equatable {
    case loading
    case success(ProductEntity)
    case error(String)
}
