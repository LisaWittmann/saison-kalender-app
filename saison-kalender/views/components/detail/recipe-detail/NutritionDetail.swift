//
//  InfoCell.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct NutritionDetail: View {
    var nutrition: Nutrition
    
    init(_ nutrition: Nutrition) {
        self.nutrition = nutrition
    }
    
    var body: some View {
        LazyVGrid(columns: layout) {
            NutritionItem(
                description: "Kalorien",
                value: "\(nutrition.calories.description)"
            )
            NutritionItem(
                description: "Eiweiß",
                value: "\(nutrition.protein.description) g"
            )
            NutritionItem(
                description: "Fett",
                value: "\(nutrition.fat.description) g"
            )
            NutritionItem(
                description: "Kohlenhydrate",
                value: "\(nutrition.carbs.description) g"
            )
        }
    }
    
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}

struct NutritionItem: View {
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


struct NutritionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let nutritions: [Nutrition] = try! context.fetch(Nutrition.fetchRequest())
        
        VStack {
            NutritionDetail(nutritions.first!)
                .modifier(SectionLayout())
        }.modifier(PageLayout())
    }
}
