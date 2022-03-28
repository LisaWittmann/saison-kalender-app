//
//  HomeView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    var season: Season
    var recipes: [Recipe]
    var viewRouter: ViewRouter
    
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "Hallo User",
                    subtitle: "Saisonal im \(season.name)",
                    color: colorBlack
                )
                
                VStack(spacing: spacingLarge) {
                    if !season.seasonals.isEmpty {
                        ContentSlider<Seasonal>(headline: "Die neuen Stars der Saison", elements: Array(season.seasonals), route: .season, viewRouter: viewRouter)
                    }
                    
                    if !recipes.isEmpty {
                        ContentSlider<Recipe>(headline: "Entdecke die neusten Rezepte", elements: recipes, route: .season, viewRouter: viewRouter)
                    }
                }
            }
        }
        .modifier(PageLayout())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(season: Season.current(context: PersistenceController.preview.container.viewContext), recipes: Recipe.current(context: PersistenceController.preview.container.viewContext),
            viewRouter: ViewRouter())
    }
}
