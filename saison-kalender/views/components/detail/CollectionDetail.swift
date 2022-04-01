//
//  CollectionDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetail: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var collection: Collection
    var close: () -> ()
    
    init(_ collection: Collection, close: @escaping () -> ()) {
        self.collection = collection
        self.close = close
    }
    
    var body: some View {
       SplitScreen(
        images: collection.recipes.map({ $0.name }),
        headline: collection.name,
        close: close
       ) {
            if !collection.recipes.isEmpty {
                RecipeMasonry(Array(collection.recipes))
                    .environmentObject(user)
            }
        }
    }
}

struct CollectionDetail_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let collections: [Collection] = try! context.fetch(Collection.fetchRequest())
        
        CollectionDetail(collections.first!, close: {})
            .environmentObject(LoggedInUser())
    }
}
