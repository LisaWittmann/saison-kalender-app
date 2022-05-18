//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI
import SwiftUIMasonry

struct Masonry<Element, Content: View>: View where Element: Representable {
    var columns: Int
    var elements: [Element]
    var content: (Element) -> Content
    
    init(_ elements: [Element], columns: Int = 2, @ViewBuilder content: @escaping (Element) -> Content) {
        self.elements = elements
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        VMasonry(columns: columns, spacing: spacingMedium) {
            ForEach(Array(elements)) { element in
                content(element)
                    .frame(width: width, height: height(element))
            }
        }
    }
    
    private var width: CGFloat {
        (contentWidth - spacing) / CGFloat(columns)
    }
    
    private func height(_ element: Element) -> CGFloat {
        let index = elements.firstIndex(of: element)!
        let factor = columns * 2
        if (index % factor == 0 || (index+1) % factor == 0) {
            return width
        }
        return width + 30
    }
    
    let spacing = spacingMedium
}

struct ElementMasonry_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())

        Page {
            Masonry(recipes) { recipe in
                RecipeTeaser(recipe)
            }
        }
        .environmentObject(AppUser.shared)
        .frame(width: contentWidth)
    }
}
