//
//  Preparation.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import Foundation
import CoreData

extension Preparation {
    
    var text: String {
        get { text_! }
        set { text_ = newValue }
    }
}

extension Preparation {
    
    static func create(title: String?, text: String, info: String?, recipe: Recipe?,in context: NSManagedObjectContext) -> Preparation? {
        let preparation = Preparation(context: context)
        preparation.id = UUID()
        preparation.title = title
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
