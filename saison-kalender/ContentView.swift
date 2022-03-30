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

    @State var user: User? = nil

    var body: some View {
        ZStack {
            switch viewRouter.currentView {
            case .home:
                HomeView(
                    user: $user,
                    viewRouter: viewRouter
                )
                    .environment(\.managedObjectContext, viewContext)
            case .season:
                SeasonView()
                    .environment(\.managedObjectContext, viewContext)
            case .recipes:
                RecipesView()
                    .environment(\.managedObjectContext, viewContext)
            case .account:
                if user != nil {
                    AccountView(user: $user)
                        .environment(\.managedObjectContext, viewContext)
                } else {
                    LoginView(user: $user)
                        .environment(\.managedObjectContext, viewContext)
                }
            }

            Menu(viewRouter: viewRouter)
                .padding(.bottom, spacingLarge)
                .frame(
                    height: UIScreen.screenHeight,
                    alignment: .bottom
                )
                
        }
        .frame(height: UIScreen.screenHeight)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
