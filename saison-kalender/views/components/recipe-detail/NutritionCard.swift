//
//  InfoCell.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct NutritionCard: View {
    var nutrition: Nutrition
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            NutritionCardItem(
                description: "Kalorien",
                value: "\(nutrition.calories.description)"
            )
            NutritionCardItem(
                description: "Eiweiß",
                value: "\(nutrition.protein.description) g"
            )
            NutritionCardItem(
                description: "Fett",
                value: "\(nutrition.fat.description) g"
            )
            NutritionCardItem(
                description: "Kohlenhydrate",
                value: "\(nutrition.carbs.description) g"
            )
        }
    }
}

struct NutritionCardItem: View {
    var description: String
    var value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadiusSmall)
                .frame(
                    width: cardWidth
                )
                .foregroundColor(colorLightGreen)
            VStack(alignment: .center) {
                Text(description)
                    .frame(
                        width: textWidth,
                        height: textHeight,
                        alignment: .center
                    )
                    .modifier(FontText())
                    .multilineTextAlignment(.center)
                    .padding(.top, spacingExtraSmall)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
                Text(value)
                    .frame(
                        width: textWidth,
                        height: textHeight,
                        alignment: .center
                    )
                    .font(.custom(fontBold, size: fontSizeHeadline2))
                    .foregroundColor(colorBlack)
                    .padding(.leading, 5)
                    .padding(.trailing, 5)
            }
            .frame(
                height: cardHeight,
                alignment: .top
            )
      
        }
    }
    
    let cardWidth = quarterContentWidth
    let cardHeight: CGFloat = 100
    let textWidth = quarterContentWidth - 10
    let textHeight: CGFloat = 40
}
