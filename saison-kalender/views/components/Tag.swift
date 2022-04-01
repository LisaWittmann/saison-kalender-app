//
//  Tag.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import WrappingHStack

struct Tag: View {
    var name: String
    var selected: Bool
    
    init(_ name: String, selected: Bool = false) {
        self.name = name
        self.selected = selected
    }
    
    var body: some View {
        Text(name)
            .padding(EdgeInsets(
                top: 5,
                leading: spacingSmall,
                bottom: 5,
                trailing: spacingSmall
            ))
            .font(.custom(fontMedium, size: fontSizeText))
            .foregroundColor(colorBlack)
            .background(selected ? colorGreen : colorLightGreen)
            .cornerRadius(cornerRadiusMedium)
    }
}

struct TagSlider<Content: Representable>: View {
    var items: [Content]
    var onSelect: (Content?) -> ()
    @State var selectedItem: Content?
    
    init(_ items: [Content], onSelect: @escaping (Content?) -> () = {_ in }) {
        self.items = items
        self.onSelect = onSelect
    }
    
    var body: some View {
        Slider(spacing: spacingExtraSmall) {
            ForEach(Array(items)) { item in
                Tag(item.name, selected: isSelected(item))
                    .onTapGesture { select(item: item)}
            }
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

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let categories = RecipeCategory.all(from: context)
        
        VStack(spacing: spacingSmall) {
            Section("Tag List") {
                TagList(categories)
            }
            Section("Tag Slider") {
                TagSlider(categories)
            }
        }.padding()
    }
}
