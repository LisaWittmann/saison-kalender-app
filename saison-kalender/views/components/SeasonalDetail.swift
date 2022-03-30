//
//  SeasonalDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI

struct SeasonalDetail: View {
    var seasonal: Seasonal
    
    @State var selectedRecipe: Recipe?
    @State var showRecipe: Bool = false
    
    var body: some View {
        SplitScreen(
            image: seasonal.name,
            headline: seasonal.name,
            subline: "Saisonal im \(Season.current.name)"
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
        .fullScreenCover(isPresented: $showRecipe, content: {
            RecipeDetailSheet(recipe: $selectedRecipe)
        })
    }
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    func showRecipeDetail(_ recipe: Recipe) {
        self.selectedRecipe = recipe
        self.showRecipe = true
    }
}

struct SeasonalDetailSheet: View {
    @Binding var seasonal: Seasonal?
    
    var body: some View {
        Group {
            if seasonal != nil {
                SeasonalDetail(seasonal: seasonal!)
            }
        }
    }
}

struct SeasonalDetail_Previews: PreviewProvider {
    static var previews: some View {
        SeasonalDetail(
            seasonal: Seasonal.current(context: PersistenceController.preview.container.viewContext).first!)
    }
}
