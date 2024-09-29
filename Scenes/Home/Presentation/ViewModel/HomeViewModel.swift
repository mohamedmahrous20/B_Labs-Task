//
//  HomeViewModel.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published @MainActor var categoryList = [CategoryScreenData]()
    @Published @MainActor var productsList = [ProductEntity]()
    
    @Published @MainActor var selectedCategory: CategoryScreenData?
    @Published @MainActor var isLoading = false
    @Published @MainActor var errorMessage: String?
    private var canFetchingMore = false
    
    private var skip = 10
    private let limit = 10
    private var total = 0
    
    private var useCase: HomeUseCaseProtocol
    
    init(useCase: HomeUseCaseProtocol = HomeUseCase()) {
        self.useCase = useCase
    }
    
    private func setLoading(to value: Bool) async {
        await MainActor.run {
            isLoading = value
        }
    }
    
    private func showError(_ value: String) async {
        await MainActor.run {
            errorMessage = value
        }
    }
    
    @MainActor
    fileprivate func didGetCategory(_ data: [CategoryScreenData]) async {
        categoryList = data
        if let firstCategory = categoryList.first {
            selectedCategory = firstCategory
            resetPagination()
            Task {
                await getProducts(categorId: firstCategory.slug)
            }
        }
    }
    
    func getCategory() async {
        await setLoading(to: true)
        let result = await useCase.getCategories()
        await setLoading(to: false)
        
        switch result {
        case .success(let data):
            await didGetCategory(data)
        case .failure(let error):
            await showError(error.localizedDescription)
        }
    }
    
    @MainActor
    fileprivate func didGetProducts(_ data: ProductListEntity) async {
        checkPagination(total: data.total ?? 0)
        await MainActor.run {
            productsList = data.products ?? []
        }
    }
    
    func getProducts(categorId: String) async {
        await setLoading(to: true)
        let result = await useCase.getProducts(limit: limit, skip: skip, id: categorId)
        await setLoading(to: false)
        
        switch result {
        case .success(let data):
            await didGetProducts(data)
        case .failure(let error):
            await showError(error.localizedDescription)
        }
    }
    
    func getProductWithPagination() async {
        guard await !isLoading && canFetchingMore else { return }
        guard let id = await selectedCategory?.slug else { return }
        await setLoading(to: true)
        let result = await useCase.getProducts(limit: limit, skip: skip, id: id)
        await setLoading(to: false)
        switch result {
        case .success(let product):
            checkPagination(total: product.total ?? 0)
            await MainActor.run {
                productsList.append(contentsOf: product.products ?? [])
            }
        case .failure(let error):
            await showError(error.localizedDescription)
        }
    }
    
    func resetPagination() {
        skip = 10
        total = 0
    }
    
    func checkPagination(total: Int) {
        self.total = total
        skip += limit
        if skip >= total {
            canFetchingMore = false
        }
    }
}
