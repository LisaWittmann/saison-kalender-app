//
//  LoggedInUser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import CoreData

class LoggedInUser: ObservableObject {
    
    @Published var user: User?
    
    private let defaults = UserDefaults.standard
    private let storeKey = "userName"
    
    init(_ user: User? = nil) {
        self.user = user
    }
    
    var name: String? { user?.name }
    
    var isPresent: Bool { user != nil }
    
    var favorites: Set<Recipe> {
        get { user?.favorites ?? [] }
        set { user?.favorites = newValue }
    }
    
    var collections: Set<Collection> {
        get { Set(user?.collections ?? []) }
        set { user?.collections = Array(newValue) }
    }
    
    func getStoredSession(_ context: NSManagedObjectContext) {
        let defaultName = defaults.object(forKey: storeKey) as? String
        if defaultName != nil {
            user = User.with(name: defaultName!, from: context)
        }
    }
    
    func login(_ user: User?) {
        self.user = user
        if user != nil {
            defaults.set(user?.name, forKey: storeKey)
        }
    }
    
    func logout() {
        user = nil
        defaults.set(nil, forKey: storeKey)
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
            // remove empty collections
            if collection.recipes.count < 1 {
                remove(collection: collection)
            }
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
        try? user?.managedObjectContext?.save()
        objectWillChange.send()
    }
}
