//
//  RecipeTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import PartialSheet

struct RecipeTeaser: View {
    @State private var showDetail = false
    
    @ObservedObject var recipe: Recipe
    var collection: Collection?
    var rect: Bool
    
    init(_ recipe: Recipe, collection: Collection? = nil, rect: Bool = false) {
        self.recipe = recipe
        self.rect = rect
    }
    
    var body: some View {
        NavigationLink(
            destination: detail(for: recipe),
            isActive: $showDetail
        ) {
            ContentTeaser(recipe.name, image: recipe.slug, rect: rect)
                .onTapGesture { showDetail.toggle() }
        }.isDetailLink(false)
    }
    
    @ViewBuilder
    private func detail(for recipe: Recipe) -> some View {
        RecipeDetail(recipe, collection: collection, close: { showDetail.toggle() })
            .navigationBarHidden(true)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        NavigationView {
            RecipeTeaser(calendar.recipes.first!)
                .environmentObject(AppUser())
                .environmentObject(calendar)
        }
    }
}
