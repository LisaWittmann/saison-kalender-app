//
//  SeasonalSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalSlider: View {
    @EnvironmentObject var user: LoggedInUser
    var seasonals: [Seasonal]
    var viewRouter: ViewRouter?
    
    var body: some View {
        Slider {
            ForEach(Array(seasonals)) { seasonal in
                SeasonalCard(seasonal: seasonal)
                    .environmentObject(user)
            }
            if viewRouter != nil {
                TeaserCard(viewRouter: viewRouter!, route: .season)
            }
        }
    }
}

struct SeasonalSlider_Previews: PreviewProvider {
    static var previews: some View {
        SeasonalSlider(
            seasonals: Seasonal.current(context: PersistenceController.preview.container.viewContext),
            viewRouter: ViewRouter()
        ).environmentObject(LoggedInUser())
    }
}
