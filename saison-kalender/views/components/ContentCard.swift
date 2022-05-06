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
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadiusSmall)
                    .frame(width: geometry.globalWidth, height: geometry.globalHeight)
                    .foregroundColor(colorLightGreen)
                VStack(alignment: .center) {
                    Text(description)
                        .padding(.leading, padding)
                        .padding(.trailing, padding)
                        .frame(width: geometry.globalWidth, alignment: .center)
                        .frame(minHeight: textHeight)
                        .modifier(FontText())
                        .multilineTextAlignment(.center)
                        .padding(.top, spacingExtraSmall)
                        
                    Text(value)
                        .padding(.leading, padding)
                        .padding(.trailing, padding)
                        .frame(width: geometry.globalWidth, alignment: .center)
                        .frame(minHeight: textHeight)
                        .font(.custom(fontBold, size: fontSizeHeadline2))
                        .foregroundColor(colorBlack)
                }
            }
        }
    }
    
    let textHeight: CGFloat = 40
    let padding: CGFloat = 5
}

struct ContentPill_Previews: PreviewProvider {
    static var previews: some View {
        ContentCard(description: "Kohlenhydrate", value: "0.2g")
            .frame(width: quarterContentWidth, height: 100)
    }
}
