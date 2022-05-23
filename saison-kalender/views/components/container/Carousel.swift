//
//  Carousel.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Carousel<Element, Content> : View where Element : Identifiable, Content: View {
    var spacing: CGFloat
    var elements: [Element]
    var content: (Element) -> Content
    
    init(
        _ elements: [Element],
        spacing: CGFloat = spacingMedium,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.spacing = spacing
        self.elements = elements
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(elements) { element in
                    content(element)
                        .padding(.leading, paddingLeft(element))
                        .padding(.trailing, paddingRight(element))
                }
            }
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, -padding)
        .padding(.trailing, -padding)
    }
    
    private func paddingLeft(_ element: Element) -> CGFloat {
        self.elements.first?.id == element.id ? padding : 0
    }
    
    private func paddingRight(_ element: Element) -> CGFloat{
        elements.last?.id == element.id ? padding : 0
    }
    
    let padding = spacingLarge
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())
        VStack {
            Carousel(recipes) { recipe in
                RecipeTeaser(recipe)
                    .frame(width: halfContentWidth, height: halfContentWidth)
            }
            Carousel(recipes) { recipe in
                RecipeTeaser(recipe)
                    .frame(width: 300, height: 300)
            }
        }
        .environmentObject(AppUser.shared)
        .frame(width: contentWidth)
    }
}
