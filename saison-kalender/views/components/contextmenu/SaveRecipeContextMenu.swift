//
//  SaveRecipeContextMenu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct SaveRecipeContextMenu: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var manager: CollectionManager
    @ObservedObject var recipe: Recipe
    @State var newCollectionName: String = ""
    
    var body: some View {
        ContextMenu {
            if manager.editing {
                ContextNavigation(
                    iconLeft: "chevron.left",
                    iconRight: saveIcon,
                    functionLeft: { manager.editing.toggle() },
                    functionRight: createCollection,
                    header: "Neue Collection"
                )
                VStack {
                    Image(recipe.name)
                        .resizable()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .frame(width: previewWidth, height: previewHeight)
                        .background(colorGreen)
                        .clipShape(RoundedRectangle(cornerRadius: previewRadius))
                    TextField("Name", text: $newCollectionName)
                        .frame(width: previewWidth, alignment: .center)
                        .font(.custom(fontMedium, size: fontSizeText))
                        .foregroundColor(colorBlack)
                }.padding(spacingExtraSmall)
            } else {
                ContextNavigation(
                    iconRight: "plus",
                    functionRight: { manager.editing.toggle() },
                    header: "Speichern in"
                )
                ScrollView(.horizontal) {
                    HStack(spacing: spacingExtraSmall) {
                        ForEach(Array(user.collections)) { collection in
                            preview(for: collection)
                        }
                    }.padding(spacingSmall)
                }
            }
        }
    }
    
    @ViewBuilder
    func preview(for collection: Collection) -> some View {
        VStack {
            Image(collection.recipes.randomElement()!.name)
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(width: previewWidth, height: previewHeight)
                .background(colorGreen)
                .clipShape(RoundedRectangle(cornerRadius: previewRadius))
            Text(collection.name)
                .frame(width: previewWidth, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.custom(fontMedium, size: fontSizeText))
                .foregroundColor(colorBlack)
        }
        .frame(width: previewWidth)
        .onTapGesture { manager.add(recipe, to: collection) }
    }
    
    private var saveIcon: String {
        newCollectionName != "" ? "arrow.right" : ""
    }
    
    private func createCollection() {
        manager.createCollection(newCollectionName, for: user, with: recipe)
    }
    
    let previewWidth: CGFloat = 100
    let previewHeight: CGFloat = 100
    let imageOpacity = 0.2
    let previewRadius: CGFloat = 20
}

struct SaveRecipeContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
        
        SaveRecipeContextMenu(
            manager: CollectionManager(),
            recipe: calendar.recipes.randomElement()!
        )
        .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser(users.first))
    }
}
