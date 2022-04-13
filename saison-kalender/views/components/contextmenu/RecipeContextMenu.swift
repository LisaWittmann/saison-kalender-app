//
//  RecipeContextMenu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct RecipeContextMenu: View {
    @EnvironmentObject var user: LoggedInUser
    @ObservedObject var manager: CollectionManager
    @State var newCollectionName: String = ""
    
    var body: some View {
        ContextMenu {
            switch(manager.mode) {
            case .add:
                ContextNavigation(
                    iconLeft: "chevron.left",
                    iconRight: saveIcon,
                    functionLeft: { manager.mode = .save },
                    functionRight: { manager.createCollection(newCollectionName, for: user) },
                    header: "Neue Collection"
                )
                VStack {
                    Image(manager.recipe!.name)
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
            case .save:
                ContextNavigation(
                    iconRight: "plus",
                    functionRight: { manager.mode = .add },
                    header: "Speichern in"
                )
                ScrollView(.horizontal) {
                    HStack(spacing: spacingExtraSmall) {
                        ForEach(Array(user.collections)) { collection in
                            preview(for: collection)
                        }
                    }.padding(spacingSmall)
                }
            case .delete:
                ContextNavigation(
                    iconRight: "xmark",
                    functionRight: manager.close,
                    header: "Rezept entfernen"
                )
                VStack {
                    Text("Entfernen")
                        .onTapGesture {
                            user.remove(recipe: manager.recipe!)
                            manager.close()
                        }
                }
            case .none:
                VStack {}
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
        .onTapGesture { manager.add(to: collection) }
    }
    
    private var saveIcon: String {
        newCollectionName != "" ? "arrow.right" : ""
    }
    
    let previewWidth: CGFloat = 100
    let previewHeight: CGFloat = 100
    let imageOpacity = 0.5
    let previewRadius: CGFloat = 20
}

struct SaveRecipeContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
        
        RecipeContextMenu(manager: CollectionManager(recipe: calendar.recipes.randomElement()))
            .environmentObject(LoggedInUser(users.first))
    }
}
