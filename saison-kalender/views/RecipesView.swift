//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    var body: some View {
        VStack {
            Headline(
                title: "Rezepte",
                subtitle: "Saisonal im März",
                color: colorBlack
            )
        }
        .modifier(PageLayout())
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
