//
//  TeaserCard.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct TeaserCard: View {
    var viewRouter: ViewRouter
    var route: Route
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadiusSmall)
                    .fill(colorLightGreen)
                    .frame(width: halfContentWidth)
                    .aspectRatio(1/1, contentMode: .fit)
            
            Button(action: {
                viewRouter.currentView = route
            }, label: {
                Image(systemName: "arrow.right")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(1/1, contentMode: .fit)
                    .frame(
                        width: quarterContentWidth,
                        alignment: .center
                    )
                    
            })
        }
    }
}

struct TeaserCard_Previews: PreviewProvider {
    static var previews: some View {
        TeaserCard(viewRouter: ViewRouter(), route: .home)
    }
}
