//
//  CollectionDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetail: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var collection: Collection
    var close: () -> ()
    
    init(_ collection: Collection, close: @escaping () -> ()) {
        self.collection = collection
        self.close = close
    }
    
    var body: some View {
       SplitScreen(
        images: collection.recipes.map{ $0.slug },
        headline: collection.name,
        subline: "\(collection.recipes.count) Rezepte",
        close: close
       ) {
            if !collection.recipes.isEmpty {
                RecipeMasonry(Array(collection.recipes))
            }
        }
    }
}

struct CollectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        CollectionDetail(collections.first!, close: {})
            .environmentObject(LoggedInUser())
            .environmentObject(ContextMenuManager())
            .environmentObject(calendar)
    }
}
