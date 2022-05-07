//
//  CollectionDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetailView: View {
    @ObservedObject var collection: Collection
    
    init(_ collection: Collection) {
        self.collection = collection
    }
    
    var body: some View {
        DetailPage(
            images: collection.recipes.map { $0.name.normalize() },
            headline: collection.name,
            subline: "\(collection.recipes.count) Rezepte"
        ) {
            Masonry(Array(collection.recipes)) { recipe in
                RecipeTeaser(recipe, collection: collection)
            }
        }
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        CollectionDetailView(collections.first!)
            .environmentObject(AppUser())
            .environmentObject(calendar)
    }
}
