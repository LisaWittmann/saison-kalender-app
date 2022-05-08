//
//  TagSlider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.04.22.
//

import SwiftUI

struct TagSlider<Element: Representable>: View {
    var items: [Element]
    var onSelect: (Element?) -> ()
    @State var selectedItem: Element?
    
    init(_ items: [Element], onSelect: @escaping (Element?) -> () = {_ in }) {
        self.items = items
        self.onSelect = onSelect
    }
    
    var body: some View {
        Carousel(Array(items), spacing: spacingExtraSmall) { item in
            Tag(item.name, selected: isSelected(item))
                .onTapGesture {
                    withAnimation {
                        select(item: item)
                    }
                }
        }
    }
    
    private func isSelected(_ item: Element) -> Bool {
        return selectedItem?.name == item.name
    }
    
    private func select(item: Element?) {
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
