//
//  User.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

class User: RepresentableData {
    @Published var name: String
    @Published var email: String
    
    @Published var favorites = Collection(name: "Favoriten", recipes: [])
    @Published var collections: Set<Collection>
    
    fileprivate var password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
        self.collections = Set<Collection>()
    }
    
    func isFavorite(recipe: Recipe) -> Bool {
        return self.favorites.recipes.contains(recipe)
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        if (collection != self.favorites) {
            add(recipe: recipe, to: self.favorites)
        }
        collection.recipes.insert(recipe)
    }
    
    func remove(recipe: Recipe, from collection: Collection) {
        if (collection.recipes.contains(recipe)) {
            collection.recipes.remove(recipe)
        }
    }
    
    func remove(recipe: Recipe) {
        for collection in self.collections {
            remove(recipe: recipe, from: collection)
        }
        remove(recipe: recipe, from: self.favorites)
    }
    
    func add(collection: Collection) -> Bool {
        if (collection.name == "") {
            return false
        }
        self.collections.insert(collection)
        return true
    }
    
    func remove(collection: Collection) {
        self.collections.remove(collection)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.name == rhs.name
    }
}
