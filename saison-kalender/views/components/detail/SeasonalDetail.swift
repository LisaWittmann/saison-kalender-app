//
//  SeasonalDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI

struct SeasonalDetail: View {
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    @ObservedObject var seasonal: Seasonal
    var close: () -> ()
    
    init(_ seasonal: Seasonal, close: @escaping () -> ()) {
        self.seasonal = seasonal
        self.close = close
    }
    
    var body: some View {
        DetailPage(
            images: [seasonal.slug],
            headline: seasonal.name,
            subline: "Saisonal im \(seasonCalendar.season.name)",
            close: close
        ) {
            if !seasonal.characteristics.isEmpty {
                body(for: seasonal.characteristics)
            }
            
            if !seasonal.recipes.isEmpty {
                body(for: Array(seasonal.recipes))
            }
        }
    }
    
    @ViewBuilder
    private func body(for characteristics: Array<Characteristic>) -> some View {
        Text("Steckbrief").modifier(FontH1())
        ForEach(characteristics) { characteristic in
            Section(characteristic.name) {
                Text(characteristic.value).modifier(FontParagraph())
            }
        }
    }
    
    @ViewBuilder
    private func body(for recipes: Array<Recipe>) -> some View {
        Text("Rezepte mit \(seasonal.name)")
            .modifier(FontH1())
        RecipeMasonry(recipes)
    }
}

struct SeasonalDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        SeasonalDetail(calendar.seasonals.randomElement()!, close: {})
            .environmentObject(AppUser())
            .environmentObject(calendar)
    }
}
