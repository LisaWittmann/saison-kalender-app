//
//  HomeView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var viewRouter: ViewRouter
    
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: [NSSortDescriptor(key: "name_", ascending: true)])
    var recipes: FetchedResults<Recipe>
    
    @FetchRequest(entity: Seasonal.entity(), sortDescriptors: [NSSortDescriptor(key: "name_", ascending: true)])
    var seasonals: FetchedResults<Seasonal>
    
    let teaserLength = 3
    
    var body: some View {
        Page {
            Headline(greeting, "Saisonal im \(Season.current.name)")
                .foregroundColor(colorBlack)
            
            VStack(spacing: spacingLarge) {
                if !seasonalTeasers.isEmpty {
                    Section("Die neuen Stars der Saison") {
                        TeaserCarousel(seasonalTeasers, teaser: {
                            LinkTeaser(to: .season)
                        }) { seasonal in
                            SeasonalTeaser(seasonal)
                        }
                    }
                }
                
                if !recipeTeasers.isEmpty {
                    Section("Entdecke alle \(Season.current.name) Rezepte") {
                        TeaserCarousel(recipeTeasers, teaser: {
                            LinkTeaser(to: .recipes)
                        }) { recipe in
                            RecipeTeaser(recipe)
                        }
                    }
                }
                
                if user.isAuthorized && !user.favorites.isEmpty {
                    Section("Deine Favoriten") {
                        TeaserCarousel(user.favorites.teaser(teaserLength), teaser: { LinkTeaser(to: .account)
                        }) { recipe in
                            RecipeTeaser(recipe)
                        }
                    }
                }
            }
            Spacer()
        }
    }
    
    private var seasonalTeasers: Array<Seasonal> {
        seasonals
            .filter({ $0.seasonal })
            .sorted()
            .teaser(teaserLength)
    }
    
    private var recipeTeasers: Array<Recipe> {
        recipes
            .filter({ $0.seasonal && user.diets.allSatisfy($0.diets.contains) })
            .sorted()
            .teaser(teaserLength)
    }
    
    private var greeting: String {
        user.name != nil ? "Hallo \(user.name!)" : "Willkommen"
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        HomeView()
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(AppUser.shared)
            .environmentObject(ViewRouter.shared)
    }
}
