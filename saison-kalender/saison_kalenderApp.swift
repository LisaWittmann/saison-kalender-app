//
//  saison_kalenderApp.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI

@main
struct saison_kalenderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
