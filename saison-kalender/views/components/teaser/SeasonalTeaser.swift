//
//  SeasonalTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var seasonal: Seasonal
    @State var showDetail = false
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        NavigationLink(
            destination: detail(for: seasonal),
            isActive: $showDetail
        ) {
            ContentTeaser(seasonal.name, image: seasonal.slug)
                .onTapGesture { showDetail.toggle() }
        }.isDetailLink(false)
    }
    
    @ViewBuilder
    private func detail(for seasonal: Seasonal) -> some View {
        SeasonalDetail(seasonal, close: { showDetail.toggle() })
            .environmentObject(user)
            .environmentObject(seasonCalendar)
            .navigationBarHidden(true)
    }
}

struct SeasonalTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        NavigationView {
            SeasonalTeaser(calendar.seasonals.randomElement()!)
                .environmentObject(LoggedInUser())
                .environmentObject(calendar)
        }
    }
}
