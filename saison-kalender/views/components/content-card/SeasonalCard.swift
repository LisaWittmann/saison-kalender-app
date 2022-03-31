//
//  SeasonalCard.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct SeasonalCard: View {
    @ObservedObject var seasonal: Seasonal
    @EnvironmentObject var user: LoggedInUser
    @State var showDetail = false
    
    var body: some View {
        ContentCard(data: seasonal, onTap: {_ in showDetail.toggle() })
            .fullScreenCover(isPresented: $showDetail, content: {
                SeasonalDetail(seasonal: seasonal, close: {
                    showDetail.toggle()
                }).environmentObject(user)
            })
    }
}

struct SeasonalCard_Previews: PreviewProvider {
    static var previews: some View {
        SeasonalCard(seasonal: Seasonal.current(context: PersistenceController.preview.container.viewContext).first!)
            .environmentObject(LoggedInUser())
    }
}
