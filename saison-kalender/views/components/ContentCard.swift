//
//  ContentCell.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct ContentCard<Data>: View where Data : Representable {
    var data: Data
    
    var body: some View {
        ZStack {
            Image(data.name)
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(
                    width: halfContentWidth,
                    height: halfContentWidth
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
                    height: halfContentWidth,
                    alignment: .bottomLeading
                )
        }
    }
    
    let imageOpacity: Double = 0.2
}

struct ContentCell_Previews: PreviewProvider {
    static var previews: some View {
        ContentCard<Seasonal>(data: Seasonal())
    }
}
