//
//  Nutrition.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import CoreData

extension Nutrition {
    
    public var id: String { recipe.name }
    
    var recipe: Recipe {
        get { recipe_! }
        set { recipe_ = newValue }
    }
}

extension Nutrition {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Nutrition> {
        let request = NSFetchRequest<Nutrition>(entityName: "Nutrition")
        request.sortDescriptors = [NSSortDescriptor(key: "recipe_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Nutrition {
    
    static func create(calories: Float, protein: Float, fat: Float, carbs: Float, recipe: Recipe, in context: NSManagedObjectContext) -> Nutrition? {
        let nutrition = Nutrition(context: context)
        nutrition.calories = calories
        nutrition.carbs = carbs
        nutrition.fat = fat
        nutrition.protein = protein
        nutrition.recipe = recipe
        do {
            try context.save()
        } catch {
            return nil
        }
        return nutrition
    }
}
