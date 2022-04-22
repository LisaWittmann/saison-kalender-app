//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @FetchRequest(entity: RecipeCategory.entity(), sortDescriptors: [ NSSortDescriptor(key: "name_", ascending: true) ])
    var categories: FetchedResults<RecipeCategory>
    
    @State var selectedCategory: RecipeCategory?

    var body: some View {
        Page {
            Headline(
                "Rezepte",
                "Saisonal im \(seasonCalendar.season.name)"
            )

            if !categories.isEmpty {
                TagSlider(
                    Array(categories),
                    onSelect: { category in selectedCategory = category }
                )
            }
            
            RecipeMasonry(seasonCalendar.filterRecipes(by: selectedCategory))
            Spacer()
        }
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        RecipesView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
            .environmentObject(ContextMenuManager())
            .environmentObject(calendar)
    }
}
