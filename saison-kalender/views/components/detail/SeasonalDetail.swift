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
            Text("Steckbrief")
                .modifier(FontH1())
            
            Section("Wissenswertes") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ").modifier(FontText())
            }
            Section("Anbau") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing. Aenean commodo ligula eget dolor.").modifier(FontText())
            }
            Section("Ernte") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.").modifier(FontText())
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
        let context = PersistenceController.preview.container.viewContext
        
        SeasonalDetail(Seasonal.current(from: context).first!, close: {})
            .environmentObject(LoggedInUser())
    }
}
