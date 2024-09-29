//
//  ProductDetails.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

struct ProductDetailsView: View {
    
    @ObservedObject var viewModel: ProductDetailsViewModel
    
    var body: some View {
        switch $viewModel.state.wrappedValue {
        case .loading:
            ProgressView()
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
                .task {
                    await viewModel.getProductDetails()
                }
        case .success(let product):
            content(product: product)
                .navigationTitle(product.title ?? "")
        case .error(let error):
            Text(error)
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    
    func content(product: ProductEntity) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                productImageCarousel(product: product)
                productTitleAndCategory(product: product)
                priceAndStockSection(product: product)
                warrantyAndPoliciesSection(product: product)
                if let tags = product.tags, !tags.isEmpty {
                    tagsSection(product: product)
                }
                descriptionSection(product: product)
                
                if let reviews = product.reviews, !reviews.isEmpty {
                    reviewsSection(product: product)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("Share Action")
                }) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
    }
    
    // MARK: - Product Image Carousel
    func productImageCarousel(product: ProductEntity) -> some View {
        TabView {
            ForEach(product.images ?? [], id: \.self) { image in
                ProductItemImage(url: image)
                    .tag(image)
                    .scaledToFit()
                    .frame(height: 250)
                    .cornerRadius(10)
            }
        }
        .frame(height: 250)
        .tabViewStyle(PageTabViewStyle())
    }
    
    // MARK: - Product Title, Category, SKU
    func productTitleAndCategory(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(product.category ?? "Unknown Category")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text(product.title ?? "Product Title")
                .font(.title2)
                .bold()
            
            Text("SKU: \(product.sku ?? "Unknown")")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
    
    // MARK: - Price, Stock, and Discount Section
    func priceAndStockSection(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("EGP \(String(format: "%.2f", product.price ?? 0.0))")
                .font(.title2)
                .bold()
            
            if let discount = product.discountPercentage, discount > 0 {
                HStack(spacing: 8) {
                    Text("Sale")
                        .foregroundColor(.red)
                        .bold()
                    
                    let discountedPrice = (product.price ?? 0.0) * (1 - discount / 100)
                    Text("EGP \(String(format: "%.2f", discountedPrice))")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .strikethrough()
                }
            }
            
            HStack {
                Text("In stock: \(product.stock ?? 0)")
                    .foregroundColor(.green)
                    .font(.footnote)
                
                Spacer()
                
                if let rating = product.rating {
                    HStack(spacing: 2) {
                        ForEach(0..<5) { star in
                            Image(systemName: star < Int(rating) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Warranty, Shipping, and Return Policies
    func warrantyAndPoliciesSection(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                if let warranty = product.warrantyInformation {
                    Text("Warranty: \(warranty)")
                        .font(.footnote)
                }
                
                Spacer()
                
                if let returnPolicy = product.returnPolicy {
                    Text("Return Policy: \(returnPolicy)")
                        .font(.footnote)
                }
            }
            
            HStack {
                Label("Shipping Info", systemImage: "truck")
                    .font(.footnote)
                Spacer()
                if let shippingInfo = product.shippingInformation {
                    Text(shippingInfo)
                        .font(.footnote)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(UIColor.systemGray6))
        )
    }
    
    // MARK: - Tags Section
    func tagsSection(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tags")
                .font(.headline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(product.tags ?? [], id: \.self) { tag in
                        Text(tag)
                            .padding(8)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                            .font(.footnote)
                    }
                }
            }
        }
    }
    
    // MARK: - Description Section
    func descriptionSection(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Description")
                .font(.headline)
            
            Text(product.description ?? "No description available.")
                .font(.body)
        }
    }
    
    // MARK: - Reviews Section
    func reviewsSection(product: ProductEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Reviews")
                .font(.headline)
            
            ForEach(product.reviews ?? [], id: \.reviewerEmail) { review in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(review.reviewerName ?? "Anonymous")
                            .font(.subheadline)
                            .bold()
                        Spacer()
                        Text(review.date ?? "")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    HStack(spacing: 2) {
                        ForEach(0..<5) { star in
                            Image(systemName: star < Int(review.rating ?? 0) ? "star.fill" : "star")
                                .foregroundColor(.yellow)
                                .font(.caption)
                        }
                    }
                    Text(review.comment ?? "")
                        .font(.body)
                }
                .padding(.vertical, 4)
                Divider()
            }
        }
    }
}

// MARK: - Example Preview with Data
struct ProductDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeRouter.productDetails(productId: 1)
            .previewLayout(.sizeThatFits)
    }
}
