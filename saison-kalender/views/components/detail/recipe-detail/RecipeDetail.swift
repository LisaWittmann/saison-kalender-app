//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI
import WrappingHStack

struct RecipeDetail: View {
    @ObservedObject var recipe: Recipe
    @EnvironmentObject var user: LoggedInUser
    var close: () -> ()
    
    init(_ recipe: Recipe, close: @escaping () -> ()) {
        self.recipe = recipe
        self.close = close
    }
    
    var body: some View {
        Card(
            images: [recipe.name],
            headline: recipe.name,
            close: close,
            icon: icon,
            onIconTap: onIconTap
        ) {
            
            Text(recipe.name).modifier(FontH1())
            
            if !recipe.categories.isEmpty {
                TagList(Array(recipe.categories))
            }
                            
            if recipe.intro != nil {
                Text(recipe.intro!)
                    .modifier(FontText())
            }
            
            if recipe.nutrition != nil {
                NutritionDetail(recipe.nutrition!)
            }
            
            if !recipe.ingredients.isEmpty {
                Section("Zutaten") {
                    ForEach(Array(recipe.ingredients)) { ingredient in
                        IngredientDetail(ingredient)
                    }
                }
            }
            
            if !recipe.preparations.isEmpty {
                Section("Zubereitung") {
                    ForEach(Array(recipe.preparations)) { preparation in
                        PreparationDetail(preparation)
                    }
                }
            }
            
            if !recipe.seasonals.isEmpty {
                Section("Saisonale Stars") {
                    SeasonalSlider(recipe.seasonalsFor(season: Season.current))
                        .environmentObject(user)
                }
            }
        }
    }
    
    var icon: String {
        if !user.isPresent {
            return ""
        }
        if user.favorites.contains(recipe) {
            return "heart.fill"
        }
        return "heart"
    }
    
    func onIconTap() {
        if user.favorites.contains(recipe) {
            user.remove(recipe: recipe)
        } else {
            user.favor(recipe: recipe)
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        RecipeDetail(Recipe.current(from: context).first!, close: {})
            .environmentObject(LoggedInUser())
    }
}
