//
//  CollectionTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct CollectionTeaser: View {
    @ObservedObject var collection: Collection
    
    init(_ collection: Collection) {
        self.collection = collection
    }
    
    var body: some View {
        NavigationLink(destination: detail(for: collection)) {
            ZStack {
                ImageGroup(collection.recipes.map { $0.name.normalize() })
                    .modifier(BlurredImageStyle())
                    .frame(width: contentWidth, height: contentHeight)
                Text(collection.name)
                    .font(.custom(fontExtraBold, size: 30))
                    .foregroundColor(colorWhite)
                    .padding([.leading, .trailing, .bottom], spacingSmall)
                    .frame(
                        width: contentWidth,
                        height: contentHeight,
                        alignment: .bottomLeading
                    )
            }.cornerRadius(cornerRadiusSmall)
        }.isDetailLink(false)
    }
    
    @ViewBuilder
    private func detail(for collection: Collection) -> some View {
        CollectionDetailView(collection)
            .navigationLink()
    }
    
    let contentHeight: CGFloat = 215
}

struct CollectionTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        NavigationView {
            CollectionTeaser(collections.first!)
                .environmentObject(AppUser())
                .environmentObject(calendar)
        }
    }
}
