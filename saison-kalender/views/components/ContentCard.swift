//
//  ContentCard.swift
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
                Text(description)
                    .padding([.leading, .trailing], padding)
                    .frame(width: geometry.size.width, height: geometry.size.height / 2)
                    .modifier(FontText())
                    .multilineTextAlignment(.center)
                    .padding(.top, spacingExtraSmall)
                Text(value)
                    .padding([.leading, .trailing], padding)
                    .frame(width: geometry.size.width, height: geometry.size.height / 2, alignment: .top)
                    .font(.custom(fontBold, size: fontSizeHeadline2))
                    
            }
            .background(colorLightGreen)
            .cornerRadius(cornerRadiusSmall)
            .foregroundColor(colorBlack)
        }
    }
    
    let padding: CGFloat = 7
}

struct ContentCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ContentCard(description: "Kohlen\u{00AD}hydrate", value: "0.2g")
                .frame(width: quarterContentWidth, height: 80)
            ContentCard(description: "Fett", value: "0.2g")
                .frame(width: quarterContentWidth, height: 80)
        }
    }
}
