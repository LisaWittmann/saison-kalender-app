//
//  TagList.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.04.22.
//

import SwiftUI
import WrappingHStack

struct TagList<Content: Representable>: View {
    var items: [Content]
    
    init(_ items: [Content]) {
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
        let categories = RecipeCategory.all(from: context)
        
        TagList(categories)
    }
}
