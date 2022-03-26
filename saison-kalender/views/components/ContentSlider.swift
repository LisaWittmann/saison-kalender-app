//
//  ContentSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct ContentSlider<Data>: View where Data: RepresentableData {
    var headline: String
    var elements: [Data]
    
    var route: Route
    var viewRouter: ViewRouter
    var onTapGesture: (Data) -> () = {_ in }

    var body: some View {
        VStack {
            Text(headline)
                .modifier(FontH2())
                .foregroundColor(colorGrey)
            
            ScrollView(.horizontal) {
                HStack(spacing: spacingMedium) {
                    ForEach(Array(elements)) { element in
                        ContentCard<Data>(data: element)
                            .frame(alignment: .leading)
                            .onTapGesture { onTapGesture(element) }
                    }
                    ContentTeaser(viewRouter: viewRouter, route: route)
                }
            }
            .padding(.top, spacingExtraSmall)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(spacingLarge)
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
        ContentSlider(
            headline: "Die neuen Stars der Saison",
            elements: [
                Seasonal(
                    name: "Mangold",
                    seasons: [.März, .April, .Mai]
                ),
                Seasonal(
                    name: "Radieschen",
                    seasons: [.März, .April, .Mai]
                )
            ],
            route: .season,
            viewRouter: ViewRouter()
        )
    }
}
