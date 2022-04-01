//
//  IngredientDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct IngredientDetail: View {
    @ObservedObject var ingredient: Ingredient
    
    init(_ ingredient: Ingredient) {
        self.ingredient = ingredient
    }
    
    var body: some View {
        HStack(spacing: spacingSmall) {
            Image(ingredient.name)
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageHeight)
            Text(ingredient.name)
                .font(.custom(fontSemiBold, size: fontSizeLabel))
                .foregroundColor(colorBlack)
            Spacer()
            Text("\(ingredient.quantity.description) \(ingredient.unit ?? "")")
                .font(.custom(fontMedium, size: fontSizeText))
                .foregroundColor(colorBlack)
        }.underlineView(opacity: 0.8)
    }
    
    let imageWidth: CGFloat = 40
    let imageHeight: CGFloat = 30
}

struct IngredientDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let ingredients: [Ingredient] = try! context.fetch(Ingredient.fetchRequest())
        
        ScrollView {
            VStack {
                ForEach(Array(ingredients)) { ingredient in
                    IngredientDetail(ingredient)
                        .padding(.leading, spacingLarge)
                        .padding(.trailing, spacingLarge)
                }
            }
            
        }
    }
}
