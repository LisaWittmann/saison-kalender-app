//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct RecipeDetail: View {
    var recipe: Recipe
    var user: User?
    
    var body: some View {
        SplitScreen(
            image: recipe.name,
            headline: recipe.name,
            icon: icon,
            onIconTap: onIconTap
        ) {
            Group {
                Text(recipe.name).modifier(FontH1())
                                
                if recipe.intro != nil {
                    Text(recipe.intro!)
                        .modifier(FontText())
                }
                
                if recipe.nutrition != nil {
                    NutritionCard(nutrition: recipe.nutrition!)
                }
                
                if !recipe.ingredients.isEmpty {
                    VStack {
                        Text("Zutaten").modifier(FontH2())
                        ForEach(Array(recipe.ingredients)) { ingredient in
                            IngredientDetail(
                                name: ingredient.name,
                                quantity: ingredient.quantity,
                                unit: ingredient.unit
                            )
                        }
                    }
                }
                
                if !recipe.preparations.isEmpty {
                    VStack {
                        Text("Zubereitung").modifier(FontH2())
                        ForEach(Array(recipe.preparations)) { preparation in
                            PreparationDetail(
                                title: preparation.title,
                                text: preparation.text,
                                info: preparation.info
                            )
                        }
                    }
                }
                
                if !recipe.seasonals.isEmpty {
                    ContentSlider<Seasonal>(headline: "Saisonale Stars", elements: Array(recipe.seasonals))
                }
            }
        }
        
    }
    
    var icon: String {
        get {
            if user?.favorites.contains(recipe) != nil {
                return "heart.fill"
            }
            return "heart"
        }
    }
    
    func onIconTap() {
        user?.favor(recipe: recipe)
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(recipe: Recipe.current(context: PersistenceController.preview.container.viewContext).first!)
    }
}
