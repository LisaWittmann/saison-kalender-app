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
            if !user.favorites.isEmpty {
                RecipeMasonry(Array(user.favorites))
                    .environmentObject(user)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let users: [User] = try! context.fetch(User.fetchRequest())
            
        AccountView()
            .environmentObject(LoggedInUser(users.first))
    }
}
