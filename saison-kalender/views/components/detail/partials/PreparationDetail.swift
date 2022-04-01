//
//  PreparationDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct PreparationDetail: View {
    @ObservedObject var preparation: Preparation
    
    init(_ preparation: Preparation) {
        self.preparation = preparation
    }
        
    var body: some View {
        VStack(spacing: 5) {
            if preparation.title != nil {
                Text(preparation.title!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Text(preparation.text).modifier(FontText())
            
            if preparation.info != nil {
                Text(preparation.info!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorCurry)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct PreparationDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let preparations: [Preparation] = try! context.fetch(Preparation.fetchRequest())
        
        ScrollView {
            VStack(spacing: spacingSmall) {
                ForEach(Array(preparations)) { preparation in
                    PreparationDetail(preparation)
                        .padding(.leading, spacingLarge)
                        .padding(.trailing, spacingLarge)
                }
            }
        }
        
    }
}

