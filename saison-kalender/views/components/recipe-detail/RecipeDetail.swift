//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct RecipeDetail: View {
    @ObservedObject var recipe: Recipe
    var user: User?
    
    @State var selectedSeasonal: Seasonal?
    @State var showSeasonal: Bool = false
    
    var body: some View {
        SplitScreen(
            image: recipe.name,
            headline: recipe.name,
            icon: icon,
            onIconTap: onIconTap
        ) {
            
            Text(recipe.name).modifier(FontH1())
                            
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
                    ContentSlider<Seasonal>(
                        elements: recipe.seasonalsFor(season: Season.current),
                        onTapGesture: showSeasonalDetail
                    )
                }
            }
        }
        .fullScreenCover(
        isPresented: $showSeasonal,
            content: {
                SeasonalDetailSheet(
                    seasonal: $selectedSeasonal
                )
            }
        )
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
    
    func showSeasonalDetail(_ seasonal: Seasonal) {
        self.selectedSeasonal = seasonal
        self.showSeasonal = selectedSeasonal != nil
    }
}

struct RecipeDetailSheet: View {
    @Binding var recipe: Recipe?
    
    var body: some View {
        Group {
            if recipe != nil {
                RecipeDetail(recipe: recipe!)
            }
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(
            recipe: Recipe.current(context: PersistenceController.preview.container.viewContext).first!
        )
    }
}
