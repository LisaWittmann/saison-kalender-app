//
//  RecipeTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var recipe: Recipe
    @State private var showDetail = false
    var rect: Bool
    
    init(_ recipe: Recipe, rect: Bool = false) {
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
        RecipeDetail(recipe, close: { showDetail.toggle() })
            .environmentObject(user)
            .environmentObject(seasonCalendar)
            .navigationBarHidden(true)
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        NavigationView {
            RecipeTeaser(calendar.recipes.first!)
                .environmentObject(LoggedInUser())
                .environmentObject(calendar)
        }
    }
}
