//
//  CollectionManager.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

class CollectionManager: ObservableObject {
    
    @Published private(set) var recipe: Recipe?
    @Published private(set) var collection: Collection?
    @Published private(set) var mode: ManagerMode?
    
    @Published var isPresented: Bool
    
    init(recipe: Recipe? = nil) {
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
}

extension CollectionManager {
    
    func createCollection(_ name: String, for user: AppUser) {
        if let recipe = self.recipe {
            let context = recipe.managedObjectContext!
            let createdCollection = Collection(context: context)
            createdCollection.name = name
            user.add(collection: createdCollection)
            user.add(recipe: recipe, to: createdCollection)
            do {
                try context.save()
            } catch {
                mode = .add
                isPresented = true
            }
            isPresented = false
        }
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
