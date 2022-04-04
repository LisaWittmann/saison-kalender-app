//
//  CollectionManager.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

class CollectionManager: ObservableObject {
    @Published var isPresented: Bool
    @Published var editing: Bool
    
    init() {
        self.isPresented = false
        self.editing = false
    }
    
    func open() {
        isPresented = true
    }
    
    func add(_ recipe: Recipe, to collection: Collection) {
        collection.recipes.insert(recipe)
        do {
            try collection.managedObjectContext?.save()
        } catch {
            isPresented = true
        }
        isPresented = false
    }
    
    func createCollection(_ name: String, for user: LoggedInUser, with recipe: Recipe) {
        let context = recipe.managedObjectContext!
        let createdCollection = Collection(context: context)
        createdCollection.id = UUID()
        createdCollection.name = name
        createdCollection.addToRecipes_(recipe)
        user.add(collection: createdCollection)
        do {
            try context.save()
        } catch {
            isPresented = true
        }
        isPresented = false
    }
}
