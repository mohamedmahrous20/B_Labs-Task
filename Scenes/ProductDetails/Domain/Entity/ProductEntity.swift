//
//  ProductEntity.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

struct ProductListEntity: Codable, Equatable {
    let products: [ProductEntity]?
    let total, skip, limit: Int?
}

struct ProductEntity: Codable, Equatable, Identifiable {
    let id: Int
    let title, description: String?
    let category: String?
    let price, discountPercentage, rating: Double?
    let stock: Int?
    let tags: [String]?
    let brand: String?
    let sku: String?
    let weight: Int?
    let dimensions: Dimensions?
    let warrantyInformation, shippingInformation: String?
    let availabilityStatus: String?
    let reviews: [Review]?
    let returnPolicy: String?
    let minimumOrderQuantity: Int?
    let meta: Meta?
    let images: [String]?
    let thumbnail: String?
}

struct Dimensions: Codable, Equatable {
    let width, height, depth: Double?
}

struct Meta: Codable, Equatable {
    let createdAt, updatedAt: String?
    let barcode: String?
    let qrCode: String?
}

struct Review: Codable, Equatable {
    let rating: Double?
    let comment: String?
    let date: String?
    let reviewerName, reviewerEmail: String?
}
