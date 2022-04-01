//
//  RecipeSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeSlider: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var viewRouter: ViewRouter
    var recipes: [Recipe]
    var route: Route?
    
    init(_ recipes: [Recipe], link route: Route? = nil) {
        self.recipes = recipes
        self.route = route
    }
    
    var body: some View {
        Slider {
            ForEach(Array(recipes)) { recipe in
                RecipeCard(recipe)
                    .environmentObject(user)
            }
            if route != nil {
                TeaserCard(to: route!)
                    .environmentObject(viewRouter)
            }
        }
    }
}

struct RecipeSlider_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        RecipeSlider(Recipe.current(from: context), link: .recipes)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
    }
}
