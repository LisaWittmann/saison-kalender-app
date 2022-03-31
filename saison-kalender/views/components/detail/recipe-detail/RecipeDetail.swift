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
    
    var body: some View {
        Detail(
            image: recipe.name,
            headline: recipe.name,
            close: close,
            icon: icon,
            onIconTap: onIconTap
        ) {
            
            Text(recipe.name).modifier(FontH1())
            
            if !recipe.categories.isEmpty {
                WrappingHStack(Array(recipe.categories)) { category in
                    Tag(category.name)
                        .padding(.bottom, spacingExtraSmall)
                }
                .padding(.bottom, -spacingExtraSmall)
            }
                            
            if recipe.intro != nil {
                Text(recipe.intro!)
                    .modifier(FontText())
            }
            
            if recipe.nutrition != nil {
                NutritionCard(nutrition: recipe.nutrition!)
            }
            
            if !recipe.ingredients.isEmpty {
                Section("Zutaten") {
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
                Section("Zubereitung") {
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
                Section("Saisonale Stars") {
                    SeasonalSlider(
                        seasonals: recipe.seasonalsFor(season: Season.current)
                    ).environmentObject(user)
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
        RecipeDetail(
            recipe: Recipe.current(context: PersistenceController.preview.container.viewContext).first!,
            close: {}
        ).environmentObject(LoggedInUser())
    }
}
