//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State var selectedRecipe: Recipe? = nil
    
    var recipes: [Recipe] {
        return Recipe.current(context: viewContext)
    }
    
    var body: some View {
        VStack {
            Headline(
                title: "Rezepte",
                subtitle: "Saisonal im \(Season.current.name)",
                color: colorBlack
            )
            
            LazyVGrid(columns: gridLayout) {
                ForEach(Array(recipes)) { recipe in
                    ContentCard<Recipe>(
                        data: recipe,
                        onTap: showRecipeDetail
                    )
                }
            }.frame(width: contentWidth, height: UIScreen.screenHeight, alignment: .topLeading)
            
        }
        .modifier(PageLayout())
        .fullScreenCover(
            item: $selectedRecipe,
            content: { recipe in
                RecipeDetail(
                    recipe: recipe,
                    back: hideRecipeDetail
                )
            }
        )
    }
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    func showRecipeDetail(_ recipe: Recipe) {
        self.selectedRecipe = recipe
    }
    
    func hideRecipeDetail() {
        self.selectedRecipe = nil
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
