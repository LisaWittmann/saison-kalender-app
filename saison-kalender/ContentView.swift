//
//  ContentView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var viewRouter: ViewRouter = ViewRouter()
   
    var season: Season {
        get { Season.current(context: self.viewContext) }
    }
    
    var recipes: [Recipe] {
        get { Recipe.current(context: self.viewContext) }
    }

    var body: some View {
        ZStack {
            switch viewRouter.currentView {
            case .home:
                HomeView(season: season, recipes: recipes, viewRouter: viewRouter)
            case .season:
                SeasonView(season: season)
            case .recipes:
                RecipesView(season: season, recipes: recipes)
            case .account:
                LoginView()
            }

            Menu(viewRouter: viewRouter)
                .padding(.bottom, spacingLarge)
                .frame(height: UIScreen.screenHeight, alignment: .bottom)
                
        }.frame(height: UIScreen.screenHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
