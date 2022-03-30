//
//  SeasonalDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI

struct SeasonalDetail: View {
    var seasonal: Seasonal
    var back: () -> ()
    
    @State var selectedRecipe: Recipe?
    
    var body: some View {
        SplitScreen(
            image: seasonal.name,
            headline: seasonal.name,
            subline: "Saisonal im \(Season.current.name)",
            back: back
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
                Text("Rezepte")
                    .modifier(FontH1())
                
                LazyVGrid(columns: gridLayout) {
                    ForEach(Array(seasonal.recipes)) { recipe in
                        ContentCard<Recipe>(data: recipe, onTap: showRecipeDetail)
                    }
                }
            }
        }
        .fullScreenCover(
            item: $selectedRecipe,
            content: { recipe in
                RecipeDetail(
                    recipe: recipe,
                    back: hideRecipeDetail
                )
        })
    }
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    func showRecipeDetail(_ recipe: Recipe) {
        self.selectedRecipe = recipe
    }
    
    func hideRecipeDetail() {
        self.selectedRecipe = nil
    }
}

struct SeasonalDetail_Previews: PreviewProvider {
    static var previews: some View {
        SeasonalDetail(
            seasonal: Seasonal.current(context: PersistenceController.preview.container.viewContext).first!,
            back: {}
        )
    }
}
