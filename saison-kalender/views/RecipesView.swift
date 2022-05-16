//
//  RecipesView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct RecipesView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: AppUser
    
    @FetchRequest(entity: RecipeCategory.entity(), sortDescriptors: [NSSortDescriptor(key: "name_", ascending: true)])
    var categories: FetchedResults<RecipeCategory>
    
    @FetchRequest(entity: Recipe.entity(), sortDescriptors: [NSSortDescriptor(key: "name_", ascending: true)])
    var recipes: FetchedResults<Recipe>
    
    @State var selectedCategory: RecipeCategory?

    var body: some View {
        Page {
            Headline("Rezepte", "Saisonal im \(Season.current.name)")
                .foregroundColor(colorBlack)

            if !categories.isEmpty {
                TagSlider(
                    Array(categories),
                    onSelect: { category in selectedCategory = category }
                )
            }
            
            if !filteredRecipes.isEmpty {
                Masonry(filteredRecipes) { recipe in
                    RecipeTeaser(recipe)
                }
            }
            Spacer()
        }
    }
    
    private var filteredRecipes: [Recipe] {
        let recipes = self.recipes
            .filter({ $0.seasonal && user.diets.allSatisfy($0.diets.contains) })
            .sorted()
    
        if let filter = selectedCategory {
            return recipes.filter { $0.categories.contains(filter) }
        }
        return recipes
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        RecipesView()
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(AppUser.shared)
            .environmentObject(ViewRouter.shared)
    }
}
