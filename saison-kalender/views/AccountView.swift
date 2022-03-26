//
//  AccountView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "Username",
                    subtitle: "Dein Bereich",
                    color: colorBlack
                )
            }
        }
        .modifier(PageLayout())
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
