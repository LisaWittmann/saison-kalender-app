//
//  ContentPill.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import SwiftUI

struct ContentCard: View {
    var description: String
    var value: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .center) {
                text(description, width: geometry.size.width)
                    .modifier(FontText())
                    .multilineTextAlignment(.center)
                    .padding(.top, spacingExtraSmall)
                text(value, width: geometry.size.width)
                    .font(.custom(fontBold, size: fontSizeHeadline2))
            }
            .background(colorLightGreen)
            .cornerRadius(cornerRadiusSmall)
        }
    }
    
    @ViewBuilder
    private func text(_ text: String, width: CGFloat) -> some View {
        Text(text)
            .padding([.leading, .trailing], padding)
            .frame(width: width, alignment: .center)
            .frame(minHeight: textHeight)
            .foregroundColor(colorBlack)
    }
    
    let textHeight: CGFloat = 40
    let padding: CGFloat = 7
}

struct ContentPill_Previews: PreviewProvider {
    static var previews: some View {
        ContentCard(description: "Kohlen\u{00AD}hydrate", value: "0.2g")
            .frame(width: quarterContentWidth)
    }
}
