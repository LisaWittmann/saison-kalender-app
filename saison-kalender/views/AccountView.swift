//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var user: LoggedInUser
    
    var body: some View {
        Page {
            Headline("\(user.name ?? "")", "Dein Bereich")
            if !user.collections.isEmpty {
                Section("Deine Collections") {
                    ForEach(Array(user.collections)) { collection in
                        CollectionTeaser(collection)
                    }
                }
            }
            if !user.favorites.isEmpty {
                Section("Deine Favoriten") {
                    RecipeMasonry(Array(user.favorites))
                }
            }
            Spacer()
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.shared
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
            
        AccountView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
