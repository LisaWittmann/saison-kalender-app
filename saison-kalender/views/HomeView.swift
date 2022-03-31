//
//  HomeView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var viewRouter: ViewRouter

    var seasonals: [Seasonal] {
        let allSeasonals = Seasonal.current(context: viewContext)
        if allSeasonals.count > teaserLength {
            return Array(allSeasonals[0...teaserLength])
        }
        return allSeasonals
    }
    
    var recipes: [Recipe] {
        let allRecipes = Recipe.current(context: viewContext)
        if allRecipes.count > teaserLength {
            return Array(allRecipes[0...teaserLength])
        }
        return allRecipes
    }
    
    var greeting: String {
        return user.name != nil ? "Hallo \(user.name!)" : "Willkommen"
    }
    
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: greeting,
                    subtitle: "Saisonal im \(Season.current.name)",
                    color: colorBlack
                )
                
                VStack(spacing: spacingLarge) {
                    if !seasonals.isEmpty {
                        Section("Die neuen Stars der Saison") {
                            SeasonalSlider(
                                seasonals: Array(seasonals),
                                viewRouter: viewRouter
                            )
                            .environmentObject(user)
                        }
                    }
                    
                    if !recipes.isEmpty {
                        Section("Entdecke die neusten Rezepte") {
                            RecipeSlider(
                                recipes: Array(recipes),
                                viewRouter: viewRouter
                            )
                            .environmentObject(user)
                        }
                    }
                }
                .padding(.leading, spacingLarge)
                .padding(.trailing, spacingLarge)
            }
        }
        .modifier(PageLayout())
    }
    
    let teaserLength = 4
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
