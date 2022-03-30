//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct RecipeDetail: View {
    @ObservedObject var recipe: Recipe
    var back: () -> ()
    var user: User?
    
    @State var selectedSeasonal: Seasonal?
    
    var body: some View {
        SplitScreen(
            image: recipe.name,
            headline: recipe.name,
            back: back,
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
            item: $selectedSeasonal,
            content: { seasonal in
                SeasonalDetail(
                    seasonal: seasonal,
                    back: hideSeasonalDetail
                )
            }
        )
    }
    
    var icon: String {
        if user?.favorites.contains(recipe) != nil {
            return "heart.fill"
        }
        return "heart"
    }
    
    func onIconTap() {
        user?.favor(recipe: recipe)
    }
    
    func showSeasonalDetail(_ seasonal: Seasonal) {
        self.selectedSeasonal = seasonal
    }
    
    func hideSeasonalDetail() {
        self.selectedSeasonal = nil
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetail(
            recipe: Recipe.current(context: PersistenceController.preview.container.viewContext).first!,
            back: {}
        )
    }
}
