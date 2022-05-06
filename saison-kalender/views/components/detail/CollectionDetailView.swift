//
//  CollectionDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetailView: View {
    @ObservedObject var collection: Collection
    var close: () -> ()
    
    init(_ collection: Collection, close: @escaping () -> ()) {
        self.collection = collection
        self.close = close
    }
    
    var body: some View {
        DetailPage(
            images: collection.recipes.map { $0.name.normalize() },
            headline: collection.name,
            subline: "\(collection.recipes.count) Rezepte",
            close: close
        ) {
            Masonry(Array(collection.recipes)) { recipe in
                RecipeTeaser(recipe)
            }
        }
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        CollectionDetailView(collections.first!, close: {})
            .environmentObject(AppUser())
            .environmentObject(calendar)
    }
}
