//
//  RecipeCard.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeCard: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var recipe: Recipe
    var rect: Bool
    
    init(_ recipe: Recipe, rect: Bool = false) {
        self.recipe = recipe
        self.rect = rect
    }
    
    @State private var showDetail = false
    
    var body: some View {
        ContentCard<Recipe>(recipe, onTap: { showDetail.toggle() }, rect: rect)
            .fullScreenCover(isPresented: $showDetail, content: {
                RecipeDetail(recipe, close: {
                    showDetail.toggle()
                }).environmentObject(user)
            })
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        RecipeCard(Recipe.current(from: context).first!)
            .environmentObject(LoggedInUser())
    }
}
