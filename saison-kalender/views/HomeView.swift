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
    
    let teaserLength = 3

    var seasonals: [Seasonal] {
        let allSeasonals = Seasonal.current(from: viewContext)
        if allSeasonals.count > teaserLength {
            return Array(allSeasonals[0...teaserLength-1])
        }
        return allSeasonals
    }
    
    var recipes: [Recipe] {
        let allRecipes = Recipe.current(from: viewContext)
        if allRecipes.count > teaserLength {
            return Array(allRecipes[0...teaserLength-1])
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
                        Slider {
                            ForEach(Array(seasonals)) { seasonal in
                                SeasonalTeaser(seasonal)
                                    .environmentObject(user)
                            }
                            LinkTeaser(to: .season)
                                .environmentObject(viewRouter)
                        }
                    }
                }
                
                if !recipes.isEmpty {
                    Section("Entdecke die neusten Rezepte") {
                        Slider {
                            ForEach(Array(recipes)) { recipe in
                                RecipeTeaser(recipe)
                                    .environmentObject(user)
                            }
                            LinkTeaser(to: .recipes)
                                .environmentObject(viewRouter)
                        }
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
