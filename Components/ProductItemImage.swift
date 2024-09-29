//
//  ProductItemImage.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

struct ProductItemImage: View {
    
    @StateObject private var viewModel = ProductImageViewModel()
    let url: String
    
    var body: some View {
        ZStack {
            if let image = viewModel.imageURL {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
            } else if viewModel.isLoading {
                ProgressView("Loading...")
                    .font(.callout)
                    .frame(width: 100, height: 50)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 150)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            viewModel.fetchImage(from: url)
        }
    }

}

struct ProductImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProductItemImage(url: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png")
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
