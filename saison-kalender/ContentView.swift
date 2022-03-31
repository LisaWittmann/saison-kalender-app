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
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: LoggedInUser

    var body: some View {
        ZStack {
            switch viewRouter.currentView {
            case .home:
                HomeView(viewRouter: viewRouter)
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(user)
            case .season:
                SeasonView()
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(user)
            case .recipes:
                RecipesView()
                    .environment(\.managedObjectContext, viewContext)
                    .environmentObject(user)
            case .account:
                if user.isPresent {
                    AccountView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(user)
                } else {
                    LoginView()
                        .environment(\.managedObjectContext, viewContext)
                        .environmentObject(user)
                }
            }

            Menu(viewRouter: viewRouter)
                .padding(.bottom, spacingLarge)
                .frame(
                    height: screenHeight,
                    alignment: .bottom
                )
        }
    
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
    }
}
