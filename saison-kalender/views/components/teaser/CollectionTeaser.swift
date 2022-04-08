//
//  CollectionTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct CollectionTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var collection: Collection
    @State var showDetail = false
    
    init(_ collection: Collection) {
        self.collection = collection
    }
    
    var body: some View {
        NavigationLink(
            destination: detail(for: collection),
            isActive: $showDetail
        ) {
            ZStack {
                ImageGroup(
                    collection.recipes.map({ $0.name }),
                    width: contentWidth,
                    height: contentHeight
                )
                .modifier(BlurredImageStyle())
                Text(collection.name)
                    .font(.custom(fontExtraBold, size: 30))
                    .foregroundColor(colorWhite)
                    .padding(
                        EdgeInsets(
                            top: 0,
                            leading: spacingSmall,
                            bottom: spacingSmall,
                            trailing: spacingSmall
                        )
                    )
                    .frame(
                        width: contentWidth,
                        height: contentHeight,
                        alignment: .bottomLeading
                    )
            }
            .frame(width: contentWidth)
            .cornerRadius(cornerRadiusSmall)
            .onTapGesture { showDetail.toggle() }
        }.isDetailLink(false)
    }
    
    @ViewBuilder
    private func detail(for collection: Collection) -> some View {
        CollectionDetail(collection, close: { showDetail.toggle() })
            .environmentObject(user)
            .environmentObject(seasonCalendar)
            .navigationBarHidden(true)
    }
    
    let contentHeight: CGFloat = 215
}

struct CollectionTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        NavigationView {
            CollectionTeaser(collections.first!)
                .environmentObject(LoggedInUser())
                .environmentObject(calendar)
        }
    }
}
