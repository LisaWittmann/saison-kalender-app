//
//  SeasonalTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalTeaser: View {    
    @ObservedObject var seasonal: Seasonal
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationLink(destination: detail(for: seasonal)) {
                ContentTeaser(seasonal.name, image: seasonal.name.normalize() )
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }.isDetailLink(false)
        }
    }
    
    @ViewBuilder
    private func detail(for seasonal: Seasonal) -> some View {
        SeasonalDetailView(seasonal)
            .navigationLink()
    }
}

struct SeasonalTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        NavigationView {
            SeasonalTeaser(calendar.seasonals.randomElement()!)
                .frame(width: halfContentWidth, height: halfContentWidth)
                .environmentObject(AppUser())
                .environmentObject(calendar)
        }
    }
}
