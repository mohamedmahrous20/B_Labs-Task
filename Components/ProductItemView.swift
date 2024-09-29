//
//  ProductItemView.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

struct ProductItemView: View {
    let product: ProductEntity

    @Binding var navigationPath: [HomeRouter]
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            productImageCarousel
            productDetails
        }
        .onTapGesture {
            navigationPath.append(.productDetails(productId: product.id))
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
        )
        .padding([.horizontal, .top])
    }
}

extension ProductItemView {
    var productImageCarousel: some View {
        TabView {
            ForEach(product.images ?? [], id: \.self) { image in
                ProductItemImage(url: image)
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
            }
        }
        .frame(width: 150, height: 150)
        .tabViewStyle(.page)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    var productDetails: some View {
        VStack(alignment: .leading, spacing: 8) {
            CategoryView(text: product.category ?? "Unknown", isSelected: true)
                .font(.footnote)
                .foregroundColor(.gray)
            
            Text(product.title ?? "Unknown Product")
                .font(.footnote)
                .textScale(.default)
                .bold()
                .lineLimit(2)

            productPrice

            StarRatingView(rating: .constant(Int(product.rating ?? 0)))
            
            Text(product.availabilityStatus ?? "")
                .font(.footnote)
                .foregroundColor(.green)
        }
        .padding(.leading, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    var productPrice: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(String(format: "EGP %.2f", product.price ?? 0.0))
                .font(.subheadline)
                .bold()

            if let discount = product.discountPercentage, discount > 0 {
                HStack {
                    Text("Sale")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.red)

                    let discountedPrice = (product.price ?? 0.0) * (1 - discount / 100)
                    Text(String(format: "EGP %.2f", discountedPrice))
                        .font(.caption)
                        .bold()
                        .foregroundColor(.gray)
                }
            }
        }
    }
}

//struct ProductViewCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductItemView(product: ProductEntity(id: 0, title: "Annibale Colombo Bed", description: "", category: "Furniture", price: 1899.99, discountPercentage: 10.0, rating: 4.5, stock: 10, tags: [], brand: "", sku: "", weight: 0, dimensions: Dimensions(width: 0.0, height: 0.0, depth: 0.0), warrantyInformation: "", shippingInformation: "", availabilityStatus: "In Stock", reviews: [], returnPolicy: "", minimumOrderQuantity: 1, meta: nil, images: ["https://cdn.dummyjson.com/products/1/thumbnail.jpg"], thumbnail: ""))
//            .previewLayout(.sizeThatFits)
//            .padding()
//    }
//}
