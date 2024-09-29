//
//  CategoryScreenData.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

struct CategoryScreenData: Equatable {
    let id = UUID()
    let slug, name: String
    
    init?(category: CategoriesEntity) {
        guard let slug = category.slug else { return nil }
        self.slug = slug
        self.name = category.name ?? "Not provided"
    }
}
