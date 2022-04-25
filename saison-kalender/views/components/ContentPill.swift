//
//  ContentPill.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import SwiftUI

struct ContentPill: View {
    var description: String
    var value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadiusSmall)
                .frame(width: cardWidth, height: cardHeight)
                .foregroundColor(colorLightGreen)
            VStack(alignment: .center) {
                Text(description)
                    .frame(
                        width: textWidth,
                        height: textHeight,
                        alignment: .center
                    )
                    .modifier(FontText())
                    .multilineTextAlignment(.center)
                    .padding(.top, spacingExtraSmall)
                    .padding(.leading, padding)
                    .padding(.trailing, padding)
                Text(value)
                    .frame(
                        width: textWidth,
                        height: textHeight,
                        alignment: .center
                    )
                    .font(.custom(fontBold, size: fontSizeHeadline2))
                    .foregroundColor(colorBlack)
                    .padding(.leading, padding)
                    .padding(.trailing, padding)
            }
            .frame(height: cardHeight, alignment: .top)
        }
    }
    
    let cardWidth = quarterContentWidth
    let cardHeight: CGFloat = 100
    let textWidth = quarterContentWidth - 10
    let textHeight: CGFloat = 40
    let padding: CGFloat = 5
}

struct ContentPill_Previews: PreviewProvider {
    static var previews: some View {
        ContentPill(description: "Protein", value: "0.2g")
    }
}
