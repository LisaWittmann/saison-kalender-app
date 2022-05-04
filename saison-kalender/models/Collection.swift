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
        recipes = Set(schema.recipes.map { Recipe.create(from: $0, in: context) })
    }
}

extension Collection {
    
    var recipes: Set<Recipe> {
        get { (recipes_ as? Set<Recipe>) ?? [] }
        set { recipes_ = newValue as NSSet }
    }
    
    var user: User {
        get { user_! }
        set { user_ = newValue }
    }
}

extension Collection: Representable {
    
    public var id: String { user.name + name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
}

extension Collection: Comparable {
    
    public static func < (lhs: Collection, rhs: Collection) -> Bool {
        lhs.id < rhs.id
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

    static func create(name: String, user: User, recipes: Set<Recipe>, in context: NSManagedObjectContext) -> Collection {
        if let collection = user.collections.filter({ $0.name == name }).first {
            collection.recipes = recipes
            try? context.save()
            return collection
        }
        let newCollection = Collection(context: context)
        newCollection.name = name
        newCollection.user = user
        newCollection.recipes = recipes
        try? context.save()
        return newCollection
    }
    
    static func create(from schema: CollectionSchema, for user: User, in context: NSManagedObjectContext) -> Collection {
        if let collection = user.collections.filter({ $0.name == schema.name }).first {
            collection.recipes = Set(schema.recipes.map { Recipe.create(from: $0, in: context) })
            try? context.save()
            return collection
        }
        let collection = Collection(from: schema, in: context)
        collection.user = user
        return collection
    }
}
