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
    @EnvironmentObject var seasonCalendar: SeasonCalendar

    var body: some View {
        ZStack {
            switch viewRouter.currentView {
            case .home:
                HomeView()
                    .environment(\.managedObjectContext, viewContext)
            case .season:
                SeasonView()
                    .environment(\.managedObjectContext, viewContext)
            case .recipes:
                RecipesView()
                    .environment(\.managedObjectContext, viewContext)
            case .account:
                if user.isPresent {
                    AccountView()
                        .environment(\.managedObjectContext, viewContext)
                } else {
                    LoginView()
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            VStack {
                Spacer()
                Menu()
            }
            .padding(.bottom, spacingLarge)
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
