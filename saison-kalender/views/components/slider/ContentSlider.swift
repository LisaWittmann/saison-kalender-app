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
    var onTap: (Content) -> () = {_ in }
    
    init(_ items: [Content], link route: Route? = nil, onTap: @escaping (Content) -> () = {_ in}) {
        self.items = items
        self.route = route
        self.onTap = onTap
    }

    var body: some View {
        Slider {
            ForEach(Array(items)) { item in
                ContentCard<Content>(item, onTap: { onTap(item) })
            }
            if route != nil {
                TeaserCard(to: route!)
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
