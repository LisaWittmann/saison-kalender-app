//
//  TagList.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.04.22.
//

import SwiftUI
import WrappingHStack

struct TagList<Element: Representable>: View {
    var items: [Element]
    
    init(_ items: [Element]) {
        self.items = items
    }
    
    var body: some View {
        WrappingHStack(Array(items)) { item in
            Tag(item.name)
                .padding(.bottom, spacingExtraSmall)
        }
        .padding(.bottom, -spacingExtraSmall)
    }
}

struct TagList_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let categories = (try? context.fetch(RecipeCategory.fetchRequest())) ?? []
        
        TagList(categories)
    }
}
