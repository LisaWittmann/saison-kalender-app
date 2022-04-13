//
//  ContentView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: LoggedInUser

    var body: some View {
        ZStack {
            NavigationView {
                switch viewRouter.currentView {
                case .home:
                    HomeView().navigationItem("Home")
                case .season:
                    SeasonView().navigationItem("Season")
                case .recipes:
                    RecipesView().navigationItem("Recipes")
                case .account:
                    if user.isPresent {
                        AccountView().navigationItem("Account")
                    } else {
                        LoginView().navigationItem("Login")
                    }
                }
            }
            Menu()
                .zIndex(1)
        }.edgesIgnoringSafeArea(.all)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        ContentView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
