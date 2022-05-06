//
//  SeasonalDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI
import WrappingHStack

struct SeasonalDetailView: View {
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    @ObservedObject var seasonal: Seasonal
    var close: () -> ()
    
    init(_ seasonal: Seasonal, close: @escaping () -> ()) {
        self.seasonal = seasonal
        self.close = close
    }
    
    var body: some View {
        DetailPage(
            images: [seasonal.name.normalize()],
            headline: seasonal.name,
            subline: "Saisonal im \(seasonCalendar.season.name)",
            close: close
        ) {
            Text("Steckbrief").modifier(FontH1())
            
            body(for: seasonal.seasons)
            
            if !seasonal.characteristics.isEmpty {
                body(for: seasonal.characteristics)
            }
            
            if !seasonal.recipes.isEmpty {
                body(for: Array(seasonal.recipes))
            }
        }
    }
    
    @ViewBuilder
    private func body(for seasons: Array<Season>) -> some View {
        Section("Saisonübersicht") {
            WrappingHStack(seasons) { season in
                Circle()
                    .fill(Color(season.name))
                    .frame(width: 15, height: 15)
            }
        }
    }
    
    @ViewBuilder
    private func body(for characteristics: Array<Characteristic>) -> some View {
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
        Masonry(Array(seasonal.recipes)) { recipe in
            RecipeTeaser(recipe)
        }
    }
}

struct SeasonalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        SeasonalDetailView(calendar.seasonals.randomElement()!, close: {})
            .environmentObject(AppUser())
            .environmentObject(calendar)
    }
}