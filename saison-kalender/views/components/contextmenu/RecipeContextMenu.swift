//
//  RecipeContextMenu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct RecipeContextMenu: View {
    @EnvironmentObject var user: AppUser
    @ObservedObject var manager: CollectionManager
    @State var newCollectionName: String = ""
    
    var body: some View {
        VStack {
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
                    Image(manager.recipe!.slug)
                        .resizable()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .frame(width: previewWidth, height: previewHeight)
                        .background(colorGreen)
                        .modifier(BlurredImageStyle())
                    TextField("Name", text: $newCollectionName)
                        .frame(width: previewWidth, alignment: .center)
                        .modifier(FontText())
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
                VStack(spacing: spacingSmall) {
                    if manager.collection != nil {
                        Text("Aus Sammlungen entfernen")
                            .modifier(FontLabel())
                            .foregroundColor(colorBlack)
                            .onTapGesture {
                                manager.removeFromCollection(for: user)
                                manager.close()
                            }
                    }
                    Text("Entfernen")
                        .modifier(FontError())
                        .onTapGesture {
                            manager.remove(for: user)
                            manager.close()
                        }
                }.padding(.top, spacingSmall)
            case .none:
                EmptyView()
            }
        }
        .frame(height: menuHeight, alignment: .top)
        .padding(.top, spacingSmall)
    }
    
    @ViewBuilder
    func preview(for collection: Collection) -> some View {
        VStack {
            Image(collection.recipes.randomElement()?.slug ?? "")
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(width: previewWidth, height: previewHeight)
                .background(colorGreen)
                .modifier(BlurredImageStyle())
            Text(collection.name)
                .frame(width: previewWidth, alignment: .center)
                .multilineTextAlignment(.center)
                .modifier(FontText())
        }
        .frame(width: previewWidth)
        .onTapGesture { manager.add(to: collection, of: user) }
    }
    
    private var saveIcon: String {
        newCollectionName != "" ? "arrow.right" : ""
    }
    
    let menuHeight: CGFloat = 200
    let previewWidth: CGFloat = 100
    let previewHeight: CGFloat = 100
    let imageOpacity = 0.5
}

struct SaveRecipeContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
        let manager = CollectionManager(recipe: calendar.recipes.randomElement())
        
        RecipeContextMenu(manager: manager)
            .environmentObject(AppUser(users.first))
            .onAppear {
                manager.mode = .save
                manager.isPresented = true
            }
    }
}
