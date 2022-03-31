//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Masonry<Content: View, Data: Identifiable>: View {
    var elements: [Data]
    var content: (Data) -> Content
    
    var body: some View {
        Grid {
            ForEach(Array(elements)) { element in
                content(element)
            }
        }
    }
}

struct RecipeMasonry: View {
    @EnvironmentObject var user: LoggedInUser
    var recipes: [Recipe]
    
    var body: some View {
        Grid {
            ForEach(Array(recipes)) { recipe in
                RecipeCard(recipe: recipe, rect: isRectangle(recipe))
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
        RecipeMasonry(recipes: Recipe.current(context: PersistenceController.preview.container.viewContext))
            .environmentObject(LoggedInUser())
            .frame(width: contentWidth)
    }
}
