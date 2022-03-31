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
        ScrollView {
            VStack {
                Headline(
                    title: "\(user.name ?? "")",
                    subtitle: "Dein Bereich",
                    color: colorBlack
                )
                if user.favorites.isEmpty {
                    RecipeMasonry(
                        recipes: Array(user.favorites)
                    )
                    .environmentObject(user)
                    .frame(
                        width: contentWidth,
                        height: screenHeight,
                        alignment: .topLeading
                    )
                }
            }
        }
        .modifier(PageLayout())
    }
}
