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
        return Recipe.current(from: viewContext)
    }
    
    var body: some View {
        VStack {
            Headline("Rezepte", "Saisonal im \(Season.current.name)")
            
            RecipeMasonry(recipes)
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
