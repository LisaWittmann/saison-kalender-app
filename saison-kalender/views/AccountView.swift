//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var selectedTab: Tab = .Favorites
    @State var openSettings = false
    
    var body: some View {
        Page {
            HStack {
                Headline("\(user.name ?? "")", "Dein Bereich")
                    .foregroundColor(colorBlack)
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
                
            case .Favorites:
                favorites()
        
            case .Collections:
                collections()
            }
        }
        .onSwipe(left: swipeLeft, right: swipeRight)
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
            Spacer()
        }
    }
    
    @ViewBuilder
    private func collections() -> some View {
        if !user.collections.isEmpty {
            ForEach(Array(user.collections)) { collection in
                CollectionTeaser(collection)
            }
            Spacer()
        }
    }
    
    private func requireAuthorizarion() {
        guard user.isAuthorized else {
            user.requireAuthorization(for: { viewRouter.navigate(to: .account) })
            viewRouter.back()
            return
        }
    }
    
    private func swipeLeft() {
        if selectedTab == .Collections {
            selectedTab = .Favorites
        }
    }
    
    private func swipeRight() {
        if selectedTab == .Favorites {
            selectedTab = .Collections
        }
    }
    
    let iconSize: CGFloat = 25
    
    enum Tab: String, CaseIterable, Representable {
        case Favorites = "Favoriten", Collections = "Sammlungen"
        
        var id: String { rawValue }
        var name: String { rawValue }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        let user = AppUser.shared
        let users: [User] = try! controller.container.viewContext.fetch(User.fetchRequest())
            
        AccountView()
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(ViewRouter.shared)
            .environmentObject(user)
            .onAppear { user.login(users.first) }
    }
}
