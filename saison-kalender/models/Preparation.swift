//
//  Preparation.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import Foundation
import CoreData

@objc(Preparation)
public class Preparation: NSManagedObject {
    
    public convenience init(from schema: PreparationSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        title = schema.title
        text = schema.text
        info = schema.info
        order = schema.order
    }
}

extension Preparation {
    
    public var id: String { recipe.name + "\(order)" }
    
    var text: String {
        get { text_! }
        set { text_ = newValue }
    }
    
    var recipe: Recipe {
        get { recipe_! }
        set { recipe_ = newValue}
    }
}

extension Preparation: Comparable {
    
    public static func < (lhs: Preparation, rhs: Preparation) -> Bool {
        if lhs.recipe == rhs.recipe {
            return lhs.order < rhs.order
        }
        return lhs.recipe < rhs.recipe
    }
}

extension Preparation {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Preparation> {
        let request = NSFetchRequest<Preparation>(entityName: "Preparation")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(from schema: PreparationSchema, for recipe: Recipe, in context: NSManagedObjectContext) -> Preparation {
        if let preparation = recipe.preparations.filter({ $0.order == schema.order }).first {
            update(preparation, from: schema)
            return preparation
        }
        let preparation = Preparation(from: schema, in: context)
        preparation.recipe = recipe
        return preparation
    }
    
    static func update(_ preparation: Preparation, from schema: PreparationSchema) {
        preparation.title = schema.title
        preparation.text = schema.text
        preparation.info = schema.info
        try? preparation.managedObjectContext?.save()
    }
}
