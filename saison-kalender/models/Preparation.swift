//
//  Preparation.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import Foundation
import CoreData

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
        return lhs.order < rhs.order
    }
}

extension Preparation {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Preparation> {
        let request = NSFetchRequest<Preparation>(entityName: "Precipe.namereparation")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Preparation {
    
    static func create(title: String?, text: String, info: String?, order: Int16, recipe: Recipe, in context: NSManagedObjectContext) -> Preparation? {
        let preparation = Preparation(context: context)
        preparation.title = title
        preparation.order = order
        preparation.info = info
        preparation.text = text
        preparation.recipe = recipe
        do {
            try context.save()
        } catch {
            return nil
        }
        return preparation
    }
}
