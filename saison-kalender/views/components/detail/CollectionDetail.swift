//
//  CollectionDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetail: View {
    @ObservedObject var collection: Collection
    var close: () -> ()
    
    init(_ collection: Collection, close: @escaping () -> ()) {
        self.collection = collection
        self.close = close
    }
    
    var body: some View {
        DetailPage(
            images: collection.recipes.map { $0.slug },
            headline: collection.name,
            subline: "\(collection.recipes.count) Rezepte",
            close: close
        ) {
            if !collection.recipes.isEmpty {
                RecipeMasonry(Array(collection.recipes), in: collection)
            }
        }
    }
}

struct CollectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        CollectionDetail(collections.first!, close: {})
            .environmentObject(AppUser())
            .environmentObject(calendar)
    }
}
