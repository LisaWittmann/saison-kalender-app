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
    @Binding var user: User?
    var viewRouter: ViewRouter

    var seasonals: [Seasonal] {
        return Seasonal.current(context: viewContext)
    }
    var recipes: [Recipe] {
        return Recipe.current(context: viewContext)
    }
    
    var greeting: String {
        return user != nil ? "Hallo \(user!.name)" : "Willkommen"
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
                            ContentSlider<Seasonal>(
                                elements: Array(seasonals),
                                route: .season,
                                viewRouter: viewRouter
                            )
                        }
                    }
                    
                    if !recipes.isEmpty {
                        Section("Entdecke die neusten Rezepte") {
                            ContentSlider<Recipe>(
                                elements: Array(recipes),
                                route: .season,
                                viewRouter: viewRouter
                            )
                        }
                    }
                }
                .padding(.leading, spacingLarge)
                .padding(.trailing, spacingLarge)
                
            }
        }
        .modifier(PageLayout())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(
            user: .constant(nil),
            viewRouter: ViewRouter()
        ).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
