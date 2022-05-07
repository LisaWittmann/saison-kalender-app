//
//  RecipeTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import PartialSheet

struct RecipeTeaser: View {
    @ObservedObject var recipe: Recipe
    var collection: Collection?
    
    init(_ recipe: Recipe, collection: Collection? = nil) {
        self.recipe = recipe
        self.collection = collection
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationLink(destination: detail(for: recipe)) {
                ContentTeaser(recipe.name, image: recipe.name.normalize())
                    .frame(width: geometry.globalWidth, height: geometry.globalHeight)
            }.isDetailLink(false)
        }
    }
    
    @ViewBuilder
    private func detail(for recipe: Recipe) -> some View {
        RecipeDetailView(recipe, collection: collection)
            .navigationBarHidden(true)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        NavigationView {
            RecipeTeaser(calendar.recipes.first!)
                .frame(width: halfContentWidth, height: halfContentWidth)
                .environmentObject(AppUser())
                .environmentObject(calendar)
        }
    }
}
