//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct AccountView: View {
    @Binding var user: User?
    
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "\(user!.name)",
                    subtitle: "Dein Bereich",
                    color: colorBlack
                )
            }
        }
        .modifier(PageLayout())
    }
}
