//
//  Collection.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

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
