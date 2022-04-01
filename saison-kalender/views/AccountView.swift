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
                Headline("\(user.name ?? "")", "Dein Bereich")
                
                if !user.favorites.isEmpty {
                    RecipeMasonry(Array(user.favorites))
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
