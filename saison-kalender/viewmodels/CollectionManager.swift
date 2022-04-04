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
    
    func set(recipe: Recipe) {
        self.recipe = recipe
    }
    
    func open(with mode: ManagerMode) {
        self.mode = mode
        self.isPresented = true
    }
    
    func close() {
        self.mode = nil
        self.isPresented = false
    }
    
    func add(to collection: Collection) {
        if let recipe = self.recipe {
            collection.recipes.insert(recipe)
            do {
                try collection.managedObjectContext?.save()
            } catch {
                mode = .save
                isPresented = true
            }
            mode = nil
            isPresented = false
        }
    }
    
    func createCollection(_ name: String, for user: LoggedInUser) {
        if let recipe = self.recipe {
            let context = recipe.managedObjectContext!
            let createdCollection = Collection(context: context)
            createdCollection.id = UUID()
            createdCollection.name = name
            createdCollection.addToRecipes_(recipe)
            user.add(collection: createdCollection)
            do {
                try context.save()
            } catch {
                mode = .add
                isPresented = true
            }
            mode = nil
            isPresented = false
        }
    }
}

enum ManagerMode: String, CaseIterable, Identifiable {
    var id: RawValue { rawValue }
    case save, add, delete
}
