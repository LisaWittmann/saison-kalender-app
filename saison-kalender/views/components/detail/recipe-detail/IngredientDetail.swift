//
//  IngredientDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct IngredientDetail: View {
    var name: String
    var quantity: Float
    var unit: String?
    
    var body: some View {
        HStack(spacing: spacingSmall) {
            Image(name)
                .resizable()
                .scaledToFill()
                .frame(width: imageWidth, height: imageHeight)
            Text(name)
                .font(.custom(fontSemiBold, size: fontSizeLabel))
                .foregroundColor(colorBlack)
            Spacer()
            Text("\(quantity.description) \(unit ?? "")")
                .font(.custom(fontMedium, size: fontSizeText))
                .foregroundColor(colorBlack)
        }.underlineView(opacity: 0.8)
    }
    
    let imageWidth: CGFloat = 40
    let imageHeight: CGFloat = 30
}

struct IngredientDetail_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            IngredientDetail(name: "Erdbeeren", quantity: 500, unit: "g")
            IngredientDetail(name: "Mangold", quantity: 1)
            IngredientDetail(name: "Salz", quantity: 1, unit: "TL")
        }
    }
}
