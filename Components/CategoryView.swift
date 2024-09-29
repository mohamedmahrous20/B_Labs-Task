//
//  CategoryView.swift
//  B_Labs Task
//
//  Created by mohamed mahrous on 22/09/2024.
//
import SwiftUI

struct CategoryView: View {
    
    var text: String
    var isSelected: Bool
    
    // Customizable properties
    var selectedBackgroundColor: Color = .gray
    var unselectedBackgroundColor: Color = .clear
    var selectedTextColor: Color = .white
    var unselectedTextColor: Color = .secondary
    var borderColor: Color = .gray
    var cornerRadius: CGFloat = 10
    var borderWidth: CGFloat = 1
    var font: Font = .headline
    var horizontalPadding: CGFloat = 16
    var verticalPadding: CGFloat = 10
    
    var body: some View {
        Text(text)
            .font(font)
            .foregroundColor(isSelected ? selectedTextColor : unselectedTextColor)
            .padding(.horizontal, horizontalPadding)
            .padding(.vertical, verticalPadding)
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isSelected ? selectedBackgroundColor : unselectedBackgroundColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(borderColor, lineWidth: borderWidth)
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isSelected)
            .frame(maxHeight: 40)
    }
}

#Preview {
    VStack {
        CategoryView(text: "Selected", isSelected: true)
        CategoryView(text: "Unselected", isSelected: false)
    }
    .padding()
}
