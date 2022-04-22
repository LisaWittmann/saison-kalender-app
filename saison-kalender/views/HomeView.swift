//
//  HomeView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    let teaserLength = 3
    
    var greeting: String {
        return user.name != nil ? "Hallo \(user.name!)" : "Willkommen"
    }
    
    var body: some View {
        Page {
            Headline(
                greeting,
                "Saisonal im \(seasonCalendar.season.name)"
            )
            
            VStack(spacing: spacingLarge) {
                if !seasonCalendar.seasonals.isEmpty {
                    Section("Die neuen Stars der Saison") {
                        teasers(for: seasonCalendar.seasonals)
                    }
                }
                
                if !seasonCalendar.recipes.isEmpty {
                    Section("Entdecke die neusten Rezepte") {
                        teasers(for: seasonCalendar.recipes)
                    }
                }
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func teasers(for recipes: [Recipe]) -> some View {
        TeaserCarousel(recipes.teaser(teaserLength), teaser: {
            LinkTeaser(to: .recipes)
        }) { recipe in
            RecipeTeaser(recipe)
        }
    }
    
    @ViewBuilder
    private func teasers(for seasonals: [Seasonal]) -> some View {
        TeaserCarousel(seasonals.teaser(teaserLength), teaser: {
            LinkTeaser(to: .season)
        }) { seasonal in SeasonalTeaser(seasonal)
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
            .environmentObject(ContextMenuManager())
            .environmentObject(calendar)
    }
}
