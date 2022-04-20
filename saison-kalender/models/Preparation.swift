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
        let request = NSFetchRequest<Preparation>(entityName: "Preparation")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Preparation {
    
    static func create(_ order: Int16, title: String? = nil, text: String, info: String? = nil, recipe: Recipe, in context: NSManagedObjectContext) -> Preparation {
        if let preparation = recipe.preparations.filter({ $0.order == order }).first {
            preparation.title = title
            preparation.text = text
            preparation.info = info
            try? context.save()
            return preparation
        }
        let newPreparation = Preparation(context: context)
        newPreparation.title = title
        newPreparation.order = order
        newPreparation.info = info
        newPreparation.text = text
        newPreparation.recipe = recipe
        try? context.save()
        return newPreparation
    }
}
