//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import SwiftUIMasonry

struct RecipeMasonry: View {
    var columns: Int
    var recipes: [Recipe]
    var collection: Collection?
    
    init(_ recipes: [Recipe], in collection: Collection? = nil, columns: Int = 2) {
        self.recipes = recipes
        self.collection = collection
        self.columns = columns
    }
    
    var body: some View {
        VMasonry(columns: columns, spacing: spacingMedium) {
            ForEach(Array(recipes)) { recipe in
                RecipeTeaser(recipe, collection: collection, rect: isRectangle(recipe))
            }
        }
    }
    
    private func isRectangle(_ recipe: Recipe) -> Bool {
        let index = recipes.firstIndex(of: recipe)!
        let factor = columns * 2
        return !(index % factor == 0 || (index+1) % factor == 0)
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
