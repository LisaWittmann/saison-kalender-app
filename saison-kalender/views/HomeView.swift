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
    
    let teaserLength = 4

    var seasonals: [Seasonal] {
        let allSeasonals = Seasonal.current(from: viewContext)
        if allSeasonals.count > teaserLength {
            return Array(allSeasonals[0...teaserLength])
        }
        return allSeasonals
    }
    
    var recipes: [Recipe] {
        let allRecipes = Recipe.current(from: viewContext)
        if allRecipes.count > teaserLength {
            return Array(allRecipes[0...teaserLength])
        }
        return allRecipes
    }
    
    var greeting: String {
        return user.name != nil ? "Hallo \(user.name!)" : "Willkommen"
    }
    
    var body: some View {
        Page {
            Headline(greeting,"Saisonal im \(Season.current.name)")
            
            VStack(spacing: spacingLarge) {
                if !seasonals.isEmpty {
                    Section("Die neuen Stars der Saison") {
                        SeasonalSlider(Array(seasonals), link: .season)
                            .environmentObject(user)
                            .environmentObject(viewRouter)
                    }
                }
                
                if !recipes.isEmpty {
                    Section("Entdecke die neusten Rezepte") {
                        RecipeSlider(Array(recipes), link: .recipes)
                            .environmentObject(user)
                            .environmentObject(viewRouter)
                    }
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewRouter: ViewRouter())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
