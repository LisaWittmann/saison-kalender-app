//
//  InfoCell.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct NutritionCard: View {
    var description: String
    var value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadiusSmall)
                .frame(
                    width: cardWidth,
                    height: cardHeight
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
                width: cardWidth,
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

struct NutritionCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: spacingExtraSmall) {
            NutritionCard(description: "Kalorien", value: "555")
            NutritionCard(description: "Eiweiß", value: "22 g")
            NutritionCard(description: "Fett", value: "10 g")
            NutritionCard(description: "Kohlenhydrate", value: "92 g")
        }
    }
}
