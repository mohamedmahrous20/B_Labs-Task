//
//  HomeView.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var viewModel: HomeViewModel
    @State private var navigationPath: [HomeRouter] = []
    
    init() {
        viewModel = .init()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationStack(path: $navigationPath) {
                categoryScrollView
                
                productScrollView
                    .navigationDestination(for: HomeRouter.self) { route in
                        route
                    }
            }
        }
        .task {
            await viewModel.getCategory()
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
}

extension HomeView {
    
    var categoryScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(viewModel.categoryList, id: \.id) { category in
                    CategoryView(text: category.name, isSelected: viewModel.selectedCategory == category)
                        .onTapGesture {
                            if viewModel.selectedCategory != category {
                                viewModel.selectedCategory = category
                                getProduct(categoryID: category.slug)
                            } else {
                                viewModel.selectedCategory = nil
                                let id = category.slug
                                
                                getProduct(categoryID: id)
                                viewModel.selectedCategory = category
                            }
                        }
                }
            }
            .padding()
        }
    }
    
    var productScrollView: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(viewModel.productsList) { product in
                    ProductItemView(product: product, navigationPath: $navigationPath)
                        .padding(.vertical, 0)
                        .task {
                            if product == viewModel.productsList.last {
                                await viewModel.getProductWithPagination()
                            }
                        }
                }
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                        .padding()
                }
            }
        }
    }
    
    private func getProduct(categoryID: String) {
        Task {
            await viewModel.getProducts(categorId: categoryID)
        }
    }
}
