//
//  RecipeCard.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeCard: View {
    @ObservedObject var recipe: Recipe
    @EnvironmentObject var user: LoggedInUser
    var rect = false
    
    @State var showDetail = false
    
    var body: some View {
        ContentCard(data: recipe, onTap: {_ in showDetail.toggle() }, rect: rect)
            .fullScreenCover(isPresented: $showDetail, content: {
                RecipeDetail(recipe: recipe, close: {
                    showDetail.toggle()
                }).environmentObject(user)
            })
    }
}

struct RecipeCard_Previews: PreviewProvider {
    static var previews: some View {
        RecipeCard(recipe: Recipe.current(context: PersistenceController.preview.container.viewContext).first!)
            .environmentObject(LoggedInUser())
    }
}
