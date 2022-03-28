//
//  PreparationDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct PreparationDetail: View {
    var title: String?
    var text: String
    var info: String?
        
    var body: some View {
        VStack(spacing: 5) {
            if title != nil {
                Text(title!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(text).modifier(FontText())
            
            if info != nil {
                Text(info!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorCurry)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct PreparationDetail_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingSmall) {
            PreparationDetail(
                title: "Vorbereitung",
                text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
            )
            PreparationDetail(
                text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.",
                info: "Tipp: Tomaten mit ins Kochwasser geben"
            )
        }
    }
}
