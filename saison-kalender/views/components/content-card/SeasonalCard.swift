//
//  SeasonalCard.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalCard: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var seasonal: Seasonal
    @State private var showDetail = false
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        ContentCard(seasonal, onTap: { showDetail.toggle() })
            .fullScreenCover(isPresented: $showDetail, content: {
                SeasonalDetail(seasonal, close: {
                    showDetail.toggle()
                }).environmentObject(user)
            })
    }
}

struct SeasonalCard_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        
        SeasonalCard(Seasonal.current(from: context).first!)
            .environmentObject(LoggedInUser())
    }
}
