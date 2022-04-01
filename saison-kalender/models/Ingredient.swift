//
//  Ingredient.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import CoreData

extension Ingredient {
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
}

extension Ingredient {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Ingredient> {
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = [NSSortDescriptor(key: "recipe_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, quanity: Float, unit: String?, recipe: Recipe?, in context: NSManagedObjectContext) -> Ingredient? {
        let ingredient = Ingredient(context: context)
        ingredient.id = UUID()
        ingredient.name = name
        ingredient.quantity = quanity
        ingredient.unit = unit
        ingredient.recipe = recipe
        do {
            try context.save()
        } catch {
            return nil
        }
        return ingredient
    }
}

