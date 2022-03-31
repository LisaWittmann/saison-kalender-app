//
//  ContentCell.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct ContentCard<Data>: View where Data : Representable {
    var data: Data
    var onTap: (Data) -> () = {_ in }
    var rect = false
    
    var body: some View {
        ZStack {
            Image(data.name)
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(
                    width: halfContentWidth,
                    height: contentHeight
                )
                .background(colorGreen)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadiusSmall))
            Text(data.name)
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
        }.onTapGesture { onTap(data) }
    }
    
    let imageOpacity: Double = 0.2
    var contentHeight: CGFloat {
        rect ? halfContentWidth + 30 : halfContentWidth
    }
}


struct ContentCell_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            ContentCard<Recipe>(data: Recipe.current(context: PersistenceController.preview.container.viewContext).first!)
            ContentCard<Recipe>(data: Recipe.current(context: PersistenceController.preview.container.viewContext).first!, rect: true)
        }.frame(alignment: .bottom)
    }
}
