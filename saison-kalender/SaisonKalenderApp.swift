//
//  saison_kalenderApp.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import SwiftUI
import CoreData

@main
struct SaisonKalenderApp: App {
    @StateObject var viewRouter = ViewRouter()
    @StateObject var user = LoggedInUser()
    @StateObject var seasonCalendar = SeasonCalendar.preview

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, seasonCalendar.context)
                .environmentObject(user)
                .environmentObject(viewRouter)
                .environmentObject(seasonCalendar)
        }
    }
}
