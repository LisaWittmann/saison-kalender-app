//
//  RecipeTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var recipe: Recipe
    @State private var showDetail = false
    var rect: Bool
    
    init(_ recipe: Recipe, rect: Bool = false) {
        self.recipe = recipe
        self.rect = rect
    }
    
    var body: some View {
        ContentTeaser(recipe, rect: rect)
            .onTapGesture { showDetail.toggle() }
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
        
        RecipeTeaser(Recipe.current(from: context).first!)
            .environmentObject(LoggedInUser())
    }
}
