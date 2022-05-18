//
//  ContentTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct ContentTeaser: View {
    var image: String
    var title: String
    
    init(_ title: String, image: String? = nil) {
        self.title = title
        self.image = image ?? title.normalize()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .opacity(imageOpacity)
                    .background(colorLightGreen)
                    .modifier(BlurredImageStyle())
                    
                Text(title.syllable())
                    .font(.custom(fontExtraBold, size: fontSizeHeadline2))
                    .foregroundColor(colorWhite)
                    .shadow(color: colorGrey, radius: shadowRadius, x: 1, y: 1)
                    .multilineTextAlignment(.leading)
                    .padding([.leading, .trailing, .bottom], spacingSmall)
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height,
                        alignment: .bottomLeading
                    )
                    
            }
        }
    }
    
    let imageOpacity: Double = 0.7
    let shadowRadius: Double = 15
}


struct ContentTeaser_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ContentTeaser("Johannisbeere")
                .frame(width: halfContentWidth, height: halfContentWidth)
            ContentTeaser("Beeren-Bowle")
                .frame(width: halfContentWidth, height: halfContentWidth)
        }.frame(alignment: .bottom)
    }
}
