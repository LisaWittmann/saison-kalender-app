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
            
            RecipeMasonry(recipes: recipes)
                .environmentObject(user)
                .frame(
                    width: contentWidth,
                    height: screenHeight,
                    alignment: .topLeading
                )
            
        }
        .modifier(PageLayout())
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
