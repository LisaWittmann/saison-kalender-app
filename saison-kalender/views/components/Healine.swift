//
//  Healine.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct Headline: View {
    var title: String
    var subtitle: String
    var color: Color
    
    var body: some View {
        VStack {
            Text(subtitle)
                .modifier(FontSubtitle())
                .foregroundColor(color)
            Text(title)
                .modifier(FontTitle())
                .foregroundColor(color)
                .padding(.top, -spacingExtraSmall)
        }
        .modifier(SectionLayout())
    }
}

struct Headline_Previews: PreviewProvider {
    static var previews: some View {
        Headline(
            title: "Feldsalat",
            subtitle: "Saisonal im März",
            color: colorBlack
        )
    }
}
