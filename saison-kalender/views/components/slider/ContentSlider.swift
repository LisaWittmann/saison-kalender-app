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
        Slider {
            ForEach(Array(elements)) { element in
                ContentCard<Data>(
                    data: element,
                    onTap: onTapGesture
                ).frame(alignment: .leading)
            }
            if viewRouter != nil && route != nil {
                TeaserCard(
                    viewRouter: viewRouter!,
                    route: route!
                )
            }
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
