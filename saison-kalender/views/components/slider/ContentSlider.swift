//
//  ContentSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct ContentSlider<Content: Representable>: View {
    @EnvironmentObject var viewRouter: ViewRouter
    var items: [Content]
    var route: Route?

    init(_ items: [Content], link route: Route? = nil) {
        self.items = items
        self.route = route
    }

    var body: some View {
        Slider {
            ForEach(Array(items)) { item in
                ContentTeaser<Content>(item)
            }
            if route != nil {
                LinkTeaser(to: route!)
                    .environmentObject(viewRouter)
            }
        }
    }
}

struct ContentSlider_Previews: PreviewProvider {
    static var previews: some View {
        ContentSlider<Seasonal>([], link: .season)
            .environmentObject(ViewRouter())
    }
}
