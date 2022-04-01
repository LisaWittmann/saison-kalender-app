//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @State var selectedCategory: RecipeCategory? = nil
    
    var categories: [RecipeCategory] {
        RecipeCategory.all(from: viewContext)
    }
    
    var recipes: [Recipe] {
        let seasonalRecipes = Recipe.current(from: viewContext).filter({ $0.isSeasonal() })
        if selectedCategory != nil {
            return seasonalRecipes.filter({ $0.categories.contains(selectedCategory!) })
        }
        return seasonalRecipes
    }

    var body: some View {
        VStack {
            Headline("Rezepte", "Saisonal im \(Season.current.name)")

            if !categories.isEmpty {
                TagSlider(categories, onSelect: { category in selectedCategory = category })
                    .padding(.leading, spacingLarge)
                    .padding(.bottom, spacingLarge)
            }
            
            RecipeMasonry(recipes)
                .environmentObject(user)
                .frame(
                    width: contentWidth,
                    height: screenHeight,
                    alignment: .topLeading
                )
            
        }
        .modifier(PageLayout())
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
