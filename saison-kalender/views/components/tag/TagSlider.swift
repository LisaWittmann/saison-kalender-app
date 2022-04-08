//
//  TagSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.04.22.
//

import SwiftUI

struct TagSlider<Content: Representable>: View {
    var items: [Content]
    var onSelect: (Content?) -> ()
    @State var selectedItem: Content?
    
    init(_ items: [Content], onSelect: @escaping (Content?) -> () = {_ in }) {
        self.items = items
        self.onSelect = onSelect
    }
    
    var body: some View {
        Carousel(Array(items), spacing: spacingExtraSmall) { item in
            Tag(item.name, selected: isSelected(item))
                .onTapGesture { select(item: item)}
        }
    }
    
    private func isSelected(_ item: Content) -> Bool {
        return selectedItem?.name == item.name
    }
    
    private func select(item: Content?) {
        if selectedItem?.name != item?.name {
            selectedItem = item
            onSelect(item)
        } else {
            selectedItem = nil
            onSelect(nil)
        }
    }
}

struct TagSlider_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let categories = try! context.fetch(RecipeCategory.fetchRequest())
        
        TagSlider(categories)
    }
}
