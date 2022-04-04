//
//  SeasonalTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var seasonal: Seasonal
    @State private var showDetail = false
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        ContentTeaser(seasonal)
            .onTapGesture { showDetail.toggle() }
            .fullScreenCover(isPresented: $showDetail) {
                SeasonalDetail(seasonal, close: {
                    showDetail.toggle()
                })
            }
    }
}

struct SeasonalTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        SeasonalTeaser(calendar.seasonals.randomElement()!)
            .environmentObject(LoggedInUser())
    }
}
