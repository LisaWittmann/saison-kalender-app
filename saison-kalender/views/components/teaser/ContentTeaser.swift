//
//  ContentTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct ContentTeaser<Content: Representable>: View {
    @ObservedObject var item: Content
    var rect: Bool
    
    init(_ item: Content, rect: Bool = false) {
        self.item = item
        self.rect = rect
    }
    
    var body: some View {
        ZStack {
            Image(item.name)
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(
                    width: halfContentWidth,
                    height: contentHeight
                )
                .background(colorGreen)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSmall))
            Text(item.name)
                .font(.custom(fontExtraBold, size: fontSizeHeadline2))
                .foregroundColor(colorWhite)
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
    
    let imageOpacity: Double = 0.2
    var contentHeight: CGFloat {
        rect ? halfContentWidth + 30 : halfContentWidth
    }
}


struct ContentTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        HStack {
            ContentTeaser<Recipe>(Recipe.current(from: context).first!)
            ContentTeaser<Recipe>(Recipe.current(from: context).last!, rect: true)
        }.frame(alignment: .bottom)
    }
}
