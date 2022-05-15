//
//  CollectionDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct CollectionDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: AppUser
    @ObservedObject var collection: Collection
    
    @State var editing: Bool = false
    @State var collectionName: String = ""
    @State var error: Bool = false
    
    init(_ collection: Collection) {
        self.collection = collection
        self.collectionName = collection.name
        self.editing = false
        self.error = false
    }
    
    var body: some View {
        DetailPage(
            images: collection.recipes.map { $0.name.normalize() },
            title: title,
            icon: { Icon(iconName, onTap: onTap, disabled: error) }
        ) {
            Masonry(Array(collection.recipes)) { recipe in
                RecipeTeaser(recipe, collection: collection)
            }
            Spacer()
        }.onSwipe(left: { dismiss() })
    }
    
    @ViewBuilder
    private func title() -> some View {
        VStack {
            Text("\(collection.recipes.count) Rezepte")
                .modifier(FontSubtitle())
                .padding(.bottom, -spacingMedium)
            Group {
                if editing {
                    TextField("Neuer Name", text: $collectionName)
                        .padding(.top, 11)
                        .padding(.bottom, -0.5)
                        .onChange(of: collectionName, perform: { text in checkName(text) })
                }
                else {
                    Text(collection.name)
                        
                }
            }.modifier(FontTitle())
        }
    }
    
    private var iconName: String {
        editing ? "checkmark" : "highlighter"
    }
    
    private func onTap() {
        if editing && !error {
            user.rename(collection, to: collectionName)
        }
        error = false
        editing.toggle()
    }
    
    private func checkName(_ name: String) {
        error = name == "" || user.collections
            .filter({ $0 != collection })
            .map({ $0.name })
            .contains(name)
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
        let collections: [Collection] = try! calendar.context.fetch(Collection.fetchRequest())
        
        CollectionDetailView(collections.first!)
            .environmentObject(AppUser(users.first))
            .environmentObject(calendar)
    }
}
