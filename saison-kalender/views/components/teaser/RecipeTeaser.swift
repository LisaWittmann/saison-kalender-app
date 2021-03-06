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
                ContentTeaser(recipe.name)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.isDetailLink(false)
        }
    }
    
    @ViewBuilder
    private func detail(for recipe: Recipe) -> some View {
        RecipeDetailView(recipe, collection: collection)
            .navigationLink()
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())
        
        NavigationView {
            RecipeTeaser(recipes.randomElement()!)
                .frame(width: halfContentWidth, height: halfContentWidth)
                .environment(\.managedObjectContext, controller.container.viewContext)
                .environmentObject(ViewRouter.shared)
                .environmentObject(AppUser.shared)
        }
    }
}
