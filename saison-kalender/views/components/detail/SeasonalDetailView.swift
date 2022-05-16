//
//  SeasonalDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI
import WrappingHStack

struct SeasonalDetailView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var seasonal: Seasonal
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        DetailPage(
            images: [seasonal.name.normalize()],
            title: { Headline(seasonal.name, "Saisonal im \(Season.current.name)")}
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
        .onSwipe(left: { dismiss() })
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
        let controller = PersistenceController.preview
        let seasonals = try! controller.container.viewContext.fetch(Seasonal.fetchRequest())
        
        SeasonalDetailView(seasonals.randomElement()!)
            .environmentObject(AppUser.shared)
    }
}
