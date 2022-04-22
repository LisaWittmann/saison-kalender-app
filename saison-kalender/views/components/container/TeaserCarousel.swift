//
//  TeaserCarousel.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.04.22.
//

import SwiftUI

struct TeaserCarousel<Data, Content, Teaser> : View
    where Data : Identifiable, Content : View, Teaser : View {
    
    var spacing: CGFloat
    var data: Array<Data>
    var content: (Data) -> Content
    var teaser: () -> Teaser
    
    init(
        _ data: Array<Data>,
        spacing: CGFloat = spacingMedium,
        @ViewBuilder teaser: @escaping () -> Teaser,
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.spacing = spacing
        self.data = data
        self.content = content
        self.teaser = teaser
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(data) { data in
                    content(data)
                        .padding(.leading, getPadding(data))
                }
                teaser()
                    .padding(.trailing, spacingLarge)
            }
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, -spacingLarge)
        .padding(.trailing, -spacingLarge)
    }
    
    private func getPadding(_ data: Data) -> CGFloat {
        if self.data.first?.id == data.id {
            return spacingLarge
        }
        return 0
    }
}

struct TeaserCarousel_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        TeaserCarousel(calendar.recipes.teaser(3), teaser: {
            LinkTeaser(to: .recipes)
        }) { recipe in
            RecipeTeaser(recipe)
        }
        .environment(\.managedObjectContext, calendar.context)
        .environmentObject(LoggedInUser())
        .environmentObject(ViewRouter())
        .environmentObject(ContextMenuManager())
        .environmentObject(calendar)
        
    }
}
