//
//  ContentView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData
import PartialSheet

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: AppUser

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
                    AccountView().navigationItem("Account")
                }
            }
            Menu()
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $user.authRequired) {
            AuthorizationView()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        ContentView()
            .environment(\.managedObjectContext, calendar.context)
            .attachPartialSheetToRoot()
            .environmentObject(AppUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
            
    }
}
