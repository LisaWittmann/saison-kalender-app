//
//  LoggedInUser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import Foundation

class LoggedInUser: ObservableObject {
    @Published var user: User?
    
    init(_ user: User? = nil) {
        self.user = user
    }
    
    var name: String? {
        user?.name
    }
    
    var favorites: Set<Recipe> {
        get { user?.favorites ?? [] }
        set { user?.favorites = newValue }
    }
    
    var collections: Set<Collection> {
        get { user?.collections ?? [] }
        set { user?.collections = newValue }
    }
    
    var isPresent: Bool {
        user != nil
    }
    
    func login(_ user: User?) {
        self.user = user
    }
    
    func favor(recipe: Recipe) {
        user?.addToFavorites_(recipe)
        save()
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        favor(recipe: recipe)
        collection.addToRecipes_(recipe)
        save()
    }
    
    func add(collection: Collection) {
        user?.addToCollections_(collection)
        save()
    }
        
    func remove(recipe: Recipe, from collection: Collection) {
        if (collection.recipes.contains(recipe)) {
            collection.recipes.remove(recipe)
        }
        save()
    }
        
    func remove(recipe: Recipe) {
        for collection in collections {
            remove(recipe: recipe, from: collection)
        }
        favorites.remove(recipe)
        save()
    }
        
    func remove(collection: Collection) {
        collections.remove(collection)
        save()
    }
    
    func save() {
        user?.save()
        objectWillChange.send()
    }
}
