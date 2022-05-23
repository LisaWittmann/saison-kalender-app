//
//  saison_kalenderApp.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData
import PartialSheet


@main
struct SaisonKalenderApp: App {
    @State var persistenceController = PersistenceController.shared
    @StateObject var viewRouter = ViewRouter.shared
    @StateObject var user = AppUser.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .attachPartialSheetToRoot()
                .environmentObject(user)
                .environmentObject(viewRouter)
                .onAppear { user.getStoredSession(from: persistenceController.container.viewContext) }
        }
    }
}
