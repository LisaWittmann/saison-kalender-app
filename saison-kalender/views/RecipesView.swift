//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    var season: Season
    var recipes: [Recipe]
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [])
    var categories: FetchedResults<Category>
    
    var body: some View {
        VStack {
            Headline(
                title: "Rezepte",
                subtitle: "Saisonal im \(season.name)",
                color: colorBlack
            )
            
            LazyVGrid(columns: layout) {
                ForEach(Array(recipes)) { recipe in
                    ContentCard<Recipe>(data: recipe)
                }
            }.frame(width: contentWidth, height: UIScreen.screenHeight, alignment: .topLeading)
            
        }
        .modifier(PageLayout())
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView(season: Season.current(context: PersistenceController.preview.container.viewContext), recipes: Recipe.current(context: PersistenceController.preview.container.viewContext))
    }
}
