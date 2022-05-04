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
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var selectedTab: Tab = .Favoriten
    @State var openSettings = false
    
    var body: some View {
        Page {
            HStack {
                Headline("\(user.name ?? "")", "Dein Bereich")
                Image(systemName: "gearshape.fill")
                    .font(.custom(fontBold, size: fontSizeHeadline1))
                    .foregroundColor(colorGreen)
                    .onTapGesture { openSettings.toggle() }
            }
            
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
        .onAppear {
            user.requireAuthorization()
            if !user.isAuthenticated {
                viewRouter.currentView = .home
            }
        }
        .fullScreenCover(isPresented: $openSettings) {
            AccountSettingsView(close: { openSettings = false })
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
            .environmentObject(AppUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
