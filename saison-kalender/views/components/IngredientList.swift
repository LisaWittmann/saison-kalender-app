//
//  IngredientList.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 07.05.22.
//

import SwiftUI

struct IngredientList: View {
    var ingredients: [Ingredient]
    var portions: Int
    
    @State var displayedPortions: Int
    let maxPortions = 30
    let minPortions = 1
    
    init(_ ingredients: [Ingredient], for portions: Int) {
        self.ingredients = ingredients
        self.portions = portions
        self.displayedPortions = portions
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("\(displayedPortions) \(displayedPortions > 1 ? "Portionen" : "Portion")")
                    .modifier(FontH2())
                Stepper(remove: removePortion, add: addPortion)
            }.padding(.bottom, spacingSmall)
            
            ForEach(Array(ingredients)) { ingredient in
                detail(for: ingredient)
            }
        }.padding(.bottom, spacingSmall)
    }
    
    @ViewBuilder
    private func detail(for ingredient: Ingredient) -> some View {
        HStack(spacing: spacingSmall) {
            Image(ingredient.group?.normalize() ?? ingredient.name.normalize())
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageHeight)
            Text(ingredient.name)
                .font(.custom(fontSemiBold, size: fontSizeLabel))
                .foregroundColor(colorBlack)
            Spacer()
            Text("\(quantityForPortion(ingredient.quantity)) \(ingredient.unit ?? "")")
                .modifier(FontText())
        }.underline(opacity: borderOpacity)
    }
    
    private func addPortion() {
        guard displayedPortions < maxPortions else { return }
        displayedPortions += 1
    }
    
    private func removePortion() {
        guard displayedPortions > minPortions else { return }
        displayedPortions -= 1
    }
    
    private func quantityForPortion(_ quantity: Float) -> String {
        (quantity / Float(portions) * Float(displayedPortions)).toString()
    }
    
    let imageHeight: CGFloat = 30
    let imageWidth: CGFloat = 40
    let borderOpacity: Double = 0.8
}

struct IngredientList_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())
        let recipe = recipes.randomElement()!
        
        IngredientList(recipe.ingredients, for: recipe.portions)
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(AppUser.shared)
            .environmentObject(ViewRouter.shared)
    }
}
