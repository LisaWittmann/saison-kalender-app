//
//  User.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
import CoreData

extension User {
    
    var favorites: Set<Recipe> {
        get { (favorites_ as? Set<Recipe>) ?? [] }
        set { favorites_ = newValue as NSSet }
    }
    
    var collections: Set<Collection> {
        get { (collections_ as? Set<Collection>) ?? [] }
        set { collections_ = newValue as NSSet }
    }
}

extension User: Representable {
    
    var email: String {
        get { email_! }
        set { email_ = newValue }
    }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var password: String {
        get { password_! }
        set { password_ = newValue }
    }
    
    public var id: String { name }
}

extension User {
    
    func favor(recipe: Recipe) {
        favorites.insert(recipe)
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        favor(recipe: recipe)
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
        favorites.remove(recipe)
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
}


