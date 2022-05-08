//
//  Headline.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct Headline: View {
    var headline: String
    var subline: String
    
    init(_ headline: String, _ subline: String) {
        self.headline = headline
        self.subline = subline
    }
    
    var body: some View {
        VStack {
            Text(subline)
                .modifier(FontSubtitle())
                .padding(.bottom, -spacingMedium)
            Text(headline)
                .modifier(FontTitle())
        }
    }
}

struct Headline_Previews: PreviewProvider {
    static var previews: some View {
        Headline("Feldsalat", "Saisonal im März")
            .foregroundColor(colorBlack)
    }
}
