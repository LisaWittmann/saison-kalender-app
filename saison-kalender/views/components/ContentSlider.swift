//
//  ContentSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct ContentSlider<Data> : View where Data : Representable {
    var elements: [Data]
    
    var route: Route?
    var viewRouter: ViewRouter?
    var onTapGesture: (Data) -> () = {_ in }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacingMedium) {
                ForEach(Array(elements)) { element in
                    ContentCard<Data>(
                        data: element,
                        onTap: onTapGesture
                    ).frame(alignment: .leading)
                }
                if viewRouter != nil && route != nil {
                    ContentTeaser(
                        viewRouter: viewRouter!,
                        route: route!
                    )
                }
            }
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ContentTeaser: View {
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

struct ContentSlider_Previews: PreviewProvider {
    static var previews: some View {
        ContentSlider<Seasonal>(
            elements: [],
            route: .season,
            viewRouter: ViewRouter()
        )
    }
}
