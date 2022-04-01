//
//  SeasonalSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalSlider: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var viewRouter: ViewRouter
    var seasonals: [Seasonal]
    var route: Route?
    
    init(_ seasonals: [Seasonal], link route: Route? = nil) {
        self.seasonals = seasonals
        self.route = route
    }
    
    var body: some View {
        Slider {
            ForEach(Array(seasonals)) { seasonal in
                SeasonalCard(seasonal)
                    .environmentObject(user)
            }
            if route != nil {
                TeaserCard(to: route!)
                    .environmentObject(viewRouter)
            }
        }
    }
}

struct SeasonalSlider_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        SeasonalSlider(Seasonal.current(from: context), link: .season)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
    }
}
