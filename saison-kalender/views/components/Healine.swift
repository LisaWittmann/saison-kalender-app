//
//  Healine.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct Headline: View {
    var headline: String
    var subline: String
    var color: Color
    
    init(_ headline: String, _ subline: String, color: Color = colorBlack) {
        self.headline = headline
        self.subline = subline
        self.color = color
    }
    
    var body: some View {
        VStack {
            Text(subline)
                .modifier(FontSubtitle())
                .foregroundColor(color)
                .padding(.bottom, -spacingMedium)
            Text(headline)
                .modifier(FontTitle())
                .foregroundColor(color)
        }
    }
}

struct Headline_Previews: PreviewProvider {
    static var previews: some View {
        Headline("Feldsalat", "Saisonal im März")
    }
}
