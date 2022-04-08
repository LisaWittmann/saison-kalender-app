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
    var rect: Bool
    
    init(_ title: String, image: String? = nil, rect: Bool = false) {
        self.title = title
        self.image = image ?? title
        self.rect = rect
    }
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .opacity(0.7)
                .blur(radius: 0.5)
                .frame(
                    width: halfContentWidth,
                    height: contentHeight
                )
                .background(colorLightGreen)
                .modifier(BlurredImageStyle())
            Text(title)
                .font(.custom(fontExtraBold, size: fontSizeHeadline2))
                .foregroundColor(colorWhite)
                .shadow(color: colorGrey, radius: 15, x: 1, y: 1)
                .multilineTextAlignment(.leading)
                .padding(
                    EdgeInsets(
                        top: 0,
                        leading: spacingSmall,
                        bottom: spacingSmall,
                        trailing: spacingSmall
                    )
                )
                .frame(
                    width: halfContentWidth,
                    height: contentHeight,
                    alignment: .bottomLeading
                )
                
        }
    }
    
    let imageOpacity: Double = 0.4
    var contentHeight: CGFloat {
        rect ? halfContentWidth + 30 : halfContentWidth
    }
}


struct ContentTeaser_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ContentTeaser("Mangold")
            ContentTeaser("Linguine mit Mangold", rect: true)
        }.frame(alignment: .bottom)
    }
}
