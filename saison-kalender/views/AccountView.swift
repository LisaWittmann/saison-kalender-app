//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

enum Tab: String, CaseIterable {
    var name: String { rawValue }
    case Favoriten, Sammlungen
}

struct AccountView: View {
    @EnvironmentObject var user: LoggedInUser
    @State var selectedTab: Tab = .Favoriten
    
    var body: some View {
        Page {
            Headline("\(user.name ?? "")", "Dein Bereich")
            
            HStack {
                ForEach(Tab.allCases, id: \.self.name) { tab in
                    Tag(tab.name, selected: tab == selectedTab)
                        .onTapGesture { selectedTab = tab }
                }
            }.frame(width: contentWidth, alignment: .leading)
            
            switch(selectedTab) {
            case .Favoriten: favorites()
            case .Sammlungen: collections()
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func favorites() -> some View {
        if !user.favorites.isEmpty {
            RecipeMasonry(Array(user.favorites))
        }
    }
    
    @ViewBuilder
    private func collections() -> some View {
        if !user.collections.isEmpty {
            ForEach(Array(user.collections)) { collection in
                CollectionTeaser(collection)
            }
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
            
        AccountView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
