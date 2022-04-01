//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct RecipeMasonry: View {
    @EnvironmentObject var user: LoggedInUser
    var recipes: [Recipe]
    
    init(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    var body: some View {
        Grid {
            ForEach(Array(recipes)) { recipe in
                RecipeCard(recipe, rect: isRectangle(recipe))
                    .environmentObject(user)
                    .padding(.top, getPadding(recipe))
            }
        }
    }
    
    func isRectangle(_ recipe: Recipe) -> Bool {
        let index = recipes.firstIndex(of: recipe)!
        return index % 4 == 0 || (index+1) % 4 == 0
    }
    
    func getPadding(_ recipe: Recipe) -> CGFloat {
        let index = recipes.firstIndex(of: recipe)!
        if (index+1) % 2 == 0 {
            return -30
        }
        return 0
    }
}

struct RecipeMasonry_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext

        RecipeMasonry(Recipe.current(from: context))
            .environmentObject(LoggedInUser())
            .frame(width: contentWidth)
    }
}
