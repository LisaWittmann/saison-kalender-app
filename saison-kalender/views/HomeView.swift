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
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    let teaserLength = 3
    
    var greeting: String {
        return user.name != nil ? "Hallo \(user.name!)" : "Willkommen"
    }
    
    var body: some View {
        Page {
            Headline(greeting,"Saisonal im \(Season.current.name)")
            
            VStack(spacing: spacingLarge) {
                if !seasonCalendar.seasonals.isEmpty {
                    Section("Die neuen Stars der Saison") {
                        Carousel {
                            ForEach(seasonCalendar.seasonals.teaser(teaserLength)) {
                                seasonal in SeasonalTeaser(seasonal)
                            }
                            LinkTeaser(to: .season)
                        }
                    }
                }
                
                if !seasonCalendar.recipes.isEmpty {
                    Section("Entdecke die neusten Rezepte") {
                        Carousel {
                            ForEach(seasonCalendar.recipes.teaser(teaserLength)) { recipe in RecipeTeaser(recipe)
                            }
                            LinkTeaser(to: .recipes)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        HomeView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
