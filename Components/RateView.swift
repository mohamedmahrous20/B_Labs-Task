//
//  RateView.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//

import SwiftUI

struct StarRatingView: View {
    
    @Binding var rating: Int
    var ratingCount: Int = 5
    
    var emptyStarImage: Image? = Image(systemName: "star")
    var filledStarImage = Image(systemName: "star.fill")
    
    var emptyStarColor: Color = .gray
    var filledStarColor: Color = .yellow
    
    var starSize: CGFloat = 20
    var starSpacing: CGFloat = 8
    
    // Optional action when rating changes
    var onRatingChanged: ((Int) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: starSpacing) {
            ForEach(1...ratingCount, id: \.self) { star in
                starImage(for: star)
                    .resizable()
                    .scaledToFit()
                    .frame(width: starSize, height: starSize)
                    .foregroundStyle(star > rating ? emptyStarColor : filledStarColor)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = star
                            onRatingChanged?(rating)
                        }
                    }
                    .accessibilityLabel("\(star) star")
                    .accessibilityRemoveTraits(.isImage)
                    .accessibilityAddTraits(star == rating ? .isSelected : .isButton)
            }
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Star Rating")
        .accessibilityValue("\(rating) out of \(ratingCount) stars")
    }
    
    private func starImage(for star: Int) -> Image {
        star > rating ? (emptyStarImage ?? filledStarImage) : filledStarImage
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: .constant(3))
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
