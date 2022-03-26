//
//  ContentView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var viewRouter = ViewRouter()
    @State var user: User?

    var body: some View {
        ZStack {
            switch viewRouter.currentView {
            case .home:
                HomeView()
            case .season:
                SeasonView(seasonals: [
                    Seasonal(
                        name: "Mangold",
                        seasons: [.März, .April]
                    ),
                    Seasonal(
                        name: "Radieschen",
                        seasons: [.März, .April]
                    )
                ])
            case .recipes:
                RecipesView()
            case .account:
                if user != nil {
                    AccountView()
                }
                else {
                    LoginView()
                }
            }
   
            Menu(viewRouter: viewRouter)
                .padding(.bottom, spacingMedium)
                .frame(height: UIScreen.screenHeight, alignment: .bottom)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
