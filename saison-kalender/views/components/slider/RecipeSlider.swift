//
//  RecipeSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeSlider: View {
    @EnvironmentObject var user: LoggedInUser
    var recipes: [Recipe]
    var viewRouter: ViewRouter?
    
    var body: some View {
        Slider {
            ForEach(Array(recipes)) { recipe in
                RecipeCard(recipe: recipe)
                    .environmentObject(user)
            }
            if viewRouter != nil {
                TeaserCard(viewRouter: viewRouter!, route: .recipes)
            }
        }
    }
}

struct RecipeSlider_Previews: PreviewProvider {
    static var previews: some View {
        RecipeSlider(
            recipes: Recipe.current(context: PersistenceController.preview.container.viewContext),
            viewRouter: ViewRouter()
        ).environmentObject(LoggedInUser())
    }
}
