//
//  CollectionTeaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct CollectionTeaser: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var collection: Collection
    @State var showDetail = false
    
    init(_ collection: Collection) {
        self.collection = collection
    }
    
    var body: some View {
        ZStack {
            ImageGroup(
                collection.recipes.map({ $0.name }),
                width: contentWidth,
                height: contentHeight
            ).clipShape(RoundedRectangle(cornerRadius: cornerRadiusSmall))
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
        .onTapGesture { showDetail.toggle() }
        .fullScreenCover(isPresented: $showDetail) {
            CollectionDetail(collection, close: { showDetail.toggle() })
                .environmentObject(user)
        }
    }
    
    let contentHeight: CGFloat = 215
}

struct CollectionTeaser_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let collections: [Collection] = (try? context.fetch(Collection.fetchRequest())) ?? []
        
        CollectionTeaser(collections.first!)
            .environmentObject(LoggedInUser())
    }
}
