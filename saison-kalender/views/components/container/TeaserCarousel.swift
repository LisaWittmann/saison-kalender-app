//
//  TeaserCarousel.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.04.22.
//

import SwiftUI

struct TeaserCarousel<Element, Content, Teaser> : View
    where Element : Identifiable, Content : View, Teaser : View {
    
    var spacing: CGFloat
    var elements: Array<Element>
    var content: (Element) -> Content
    var teaser: () -> Teaser
    
    init(
        _ elements: Array<Element>,
        spacing: CGFloat = spacingMedium,
        @ViewBuilder teaser: @escaping () -> Teaser,
        @ViewBuilder content: @escaping (Element) -> Content
    ) {
        self.spacing = spacing
        self.elements = elements
        self.content = content
        self.teaser = teaser
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(elements) { data in
                    content(data)
                        .frame(width: halfContentWidth, height: halfContentWidth)
                        .padding(.leading, padding(data))
                }
                teaser()
                    .frame(width: halfContentWidth, height: halfContentWidth)
                    .padding(.trailing, spacingLarge)
                    
            }
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, -spacingLarge)
        .padding(.trailing, -spacingLarge)
    }
    
    private func padding(_ element: Element) -> CGFloat {
        elements.first?.id == element.id ? spacingLarge : 0
    }
}

struct TeaserCarousel_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())
        
        TeaserCarousel(recipes.teaser(3), teaser: { LinkTeaser(to: .recipes) }) { recipe in
            RecipeTeaser(recipe)
        }
        .environment(\.managedObjectContext, controller.container.viewContext)
        .environmentObject(AppUser.shared)
        .environmentObject(ViewRouter.shared)
    }
}
