//
//  SeasonalDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI

struct SeasonalDetail: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var seasonal: Seasonal
    var close: () -> ()
    
    init(_ seasonal: Seasonal, close: @escaping () -> ()) {
        self.seasonal = seasonal
        self.close = close
    }
    
    var body: some View {
        SplitScreen(
            images: [seasonal.name],
            headline: seasonal.name,
            subline: "Saisonal im \(Season.current.name)",
            close: close
        ) {
            
            if !seasonal.characteristics.isEmpty {
                Text("Steckbrief").modifier(FontH1())
                ForEach(Array(seasonal.characteristics)) { characteristic in
                    Section(characteristic.name) {
                        Text(characteristic.value).modifier(FontText())
                    }
                }
            }
            
            if !seasonal.recipes.isEmpty {
                Text("Rezepte").modifier(FontH1())
                RecipeMasonry(Array(seasonal.recipes))
                    .environmentObject(user)
            }
        }
    }
}

struct SeasonalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        SeasonalDetail(calendar.seasonals.first!, close: {})
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
