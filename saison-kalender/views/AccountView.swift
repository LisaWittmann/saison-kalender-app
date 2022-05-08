//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

enum Tab: String, CaseIterable {
    var name: String { rawValue }
    case Favorites = "Favoriten", Collections = "Sammlungen"
}

struct AccountView: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var selectedTab: Tab = .Favorites
    @State var openSettings = false
    
    var body: some View {
        Page {
            HStack {
                Headline("\(user.name ?? "")", "Dein Bereich")
                Icon("gearshape.fill", onTap: { openSettings.toggle() })
                    .foregroundColor(colorGreen)
                    .frame(width: iconSize, height: iconSize)
            }
            
            HStack {
                ForEach(Tab.allCases, id: \.self.name) { tab in
                    Tag(tab.name, selected: tab == selectedTab)
                        .onTapGesture { selectedTab = tab }
                }
            }.frame(width: contentWidth, alignment: .leading)
            
            switch(selectedTab) {
            case .Favorites: favorites()
            case .Collections: collections()
            }
            
            Spacer()
        }
        .onAppear { requireAuthorizarion() }
        .fullScreenCover(isPresented: $openSettings) {
            AccountSettingsView(close: { openSettings = false })
        }
    }
    
    @ViewBuilder
    private func favorites() -> some View {
        if !user.favorites.isEmpty {
            Masonry(Array(user.favorites)) { recipe in
                RecipeTeaser(recipe)
            }
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
    
    private func requireAuthorizarion() {
        guard user.isAuthorized else {
            user.requireAuthorization(for: { viewRouter.navigate(to: .account) })
            viewRouter.navigate(to: .home)
            return
        }
    }
    
    let iconSize: CGFloat = 25
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
            
        AccountView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
