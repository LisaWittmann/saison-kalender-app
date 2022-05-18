//
//  Collection.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData
import SwiftUI

@objc(Collection)
public class Collection: NSManagedObject {
    
    public convenience init(from schema: CollectionSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
        recipes = schema.recipes.map { Recipe.create(from: $0, in: context) }
    }
}

extension Collection: Representable {
    
    public var id: String { user.id + name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var recipes: Array<Recipe> {
        get { (recipes_ as? Set<Recipe>)?.sorted() ?? [] }
        set { recipes_ = Set(newValue) as NSSet }
    }
    
    var user: User {
        get { user_! }
        set { user_ = newValue }
    }
}

extension Collection: Comparable {
    
    public static func < (lhs: Collection, rhs: Collection) -> Bool {
        if lhs.user == rhs.user {
            return lhs.name < rhs.name
        }
        return lhs.user < rhs.user
    }
}

extension Collection {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Collection> {
        let request = NSFetchRequest<Collection>(entityName: "Collection")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Collection {

    static func create(name: String, user: User, recipes: [Recipe], in context: NSManagedObjectContext) -> Collection {
        if let collection = user.collections.filter({ $0.name == name }).first {
            collection.recipes = recipes
            return collection
        }
        let newCollection = Collection(context: context)
        newCollection.name = name
        newCollection.user = user
        newCollection.recipes = recipes
        return newCollection
    }
    
    static func create(from schema: CollectionSchema, for user: User, in context: NSManagedObjectContext) -> Collection {
        if let collection = user.collections.filter({ $0.name == schema.name }).first {
            update(collection, from: schema)
            return collection
        }
        let collection = Collection(from: schema, in: context)
        collection.user = user
        return collection
    }
    
    static func update(_ collection: Collection, from schema: CollectionSchema) {
        collection.recipes = schema.recipes.map { Recipe.create(from: $0, in: collection.managedObjectContext!) }
        try? collection.managedObjectContext?.save()
    }
}
