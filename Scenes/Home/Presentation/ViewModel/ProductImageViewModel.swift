//
//  ProductImageViewModel.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 26/09/2024.
//

import Foundation
import SwiftUI
import Combine

class ProductImageViewModel: ObservableObject {

    @Published var imageURL: UIImage? = nil
    @Published var isLoading = false
    @Published var errorMessage: String? = nil

    private var cancellables = Set<AnyCancellable>()

    func fetchImage(from urlString: String?) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return 
        }

        self.isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                if case .failure(let error) = completion {
                    self.errorMessage = "Failed to load image: \(error.localizedDescription)"
                }
                self.isLoading = false  // Stop the loading indicator
            }, receiveValue: { [weak self] imageURL in
                guard let self else {return}
                self.imageURL = imageURL
            })
            .store(in: &cancellables)
    }
}
