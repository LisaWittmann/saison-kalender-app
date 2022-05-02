//
//  CollectionManager.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

class CollectionManager: ObservableObject {
    
    @Published var recipe: Recipe?
    @Published var collection: Collection?
    
    @Published var isPresented: Bool
    @Published var mode: ManagerMode?
    
    init() {
        self.recipe = nil
        self.mode = nil
        self.isPresented = false
    }
    
    init(recipe: Recipe?) {
        self.recipe = recipe
        self.mode = nil
        self.isPresented = false
    }
    
    func set(recipe: Recipe, with collection: Collection? = nil) {
        self.recipe = recipe
        self.collection = collection
    }
    
    func open(with mode: ManagerMode) {
        self.mode = mode
        self.isPresented = true
    }
    
    func close() {
        self.mode = nil
        self.isPresented = false
    }
    
    func add(to collection: Collection, of user: AppUser) {
        if let recipe = self.recipe {
            user.add(recipe: recipe, to: collection)
            if collection.recipes.contains(recipe) {
                isPresented = false
            } else {
                mode = .save
                isPresented = true
            }
        }
    }
    
    func createCollection(_ name: String, for user: AppUser) {
        if let recipe = self.recipe {
            let context = recipe.managedObjectContext!
            let createdCollection = Collection(context: context)
            createdCollection.name = name
            createdCollection.addToRecipes_(recipe)
            user.add(collection: createdCollection)
            do {
                try context.save()
            } catch {
                mode = .add
                isPresented = true
            }
            isPresented = false
        }
    }
    
    func remove(for user: AppUser) {
        if recipe != nil {
            user.remove(recipe: recipe!)
            isPresented = false
        }
    }
    
    func removeFromCollection(for user: AppUser) {
        if collection != nil && recipe != nil {
            user.remove(recipe: recipe!, from: collection!)
            collection = nil
        } else {
            remove(for: user)
            isPresented = false
        }
    }
}

enum ManagerMode: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case save, add, delete
}
