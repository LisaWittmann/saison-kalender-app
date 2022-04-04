//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import SwiftUIMasonry

struct RecipeMasonry: View {
    var recipes: [Recipe]
    
    init(_ recipes: [Recipe]) {
        self.recipes = recipes
    }
    
    var body: some View {
        VMasonry(columns: 2, spacing: spacingMedium) {
            ForEach(Array(recipes)) { recipe in
                RecipeTeaser(recipe, rect: isRectangle(recipe))
            }
        }
    }
    
    private func isRectangle(_ recipe: Recipe) -> Bool {
        let index = recipes.firstIndex(of: recipe)!
        return !(index % 4 == 0 || (index+1) % 4 == 0)
    }
}

struct RecipeMasonry_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview

        NavigationView {
            RecipeMasonry(calendar.recipes)
                .environmentObject(LoggedInUser())
                .environmentObject(calendar)
                .frame(width: contentWidth)
        }
    }
}
