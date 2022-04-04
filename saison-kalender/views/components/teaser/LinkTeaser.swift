//
//  LinkTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct LinkTeaser: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var route: Route
    
    init(to route: Route) {
        self.route = route
    }
    
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
                    .foregroundColor(colorGreen)
                    .frame(
                        width: quarterContentWidth,
                        alignment: .center
                    )
                    
            })
        }
    }
}

struct LinkTeaser_Previews: PreviewProvider {
    static var previews: some View {
        LinkTeaser(to: .home)
            .environmentObject(ViewRouter())
    }
}
