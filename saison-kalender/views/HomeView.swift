//
//  HomeView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "Hallo User",
                    subtitle: "Saisonal im März",
                    color: colorBlack
                )
            }
        }
        .modifier(PageLayout())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
