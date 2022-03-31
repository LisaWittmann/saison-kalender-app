//
//  saison_kalenderApp.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI

@main
struct SaisonKalenderApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject var viewRouter: ViewRouter = ViewRouter()
    @StateObject var user: LoggedInUser = LoggedInUser()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(user)
                .environmentObject(viewRouter)
        }
    }
}
