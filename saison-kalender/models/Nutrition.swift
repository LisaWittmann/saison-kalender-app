//
//  Nutrition.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import CoreData

@objc(Nutrition)
public class Nutrition: NSManagedObject {
    
    public convenience init(from schema: NutritionSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        calories = schema.calories
        carbs = schema.carbs
        protein = schema.protein
        fat = schema.fat
    }
}

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
    
    static func create(from schema: NutritionSchema, for recipe: Recipe, in context: NSManagedObjectContext) -> Nutrition {
        if let nutrition = recipe.nutrition {
            update(nutrition, from: schema)
            return nutrition
        }
        let nutrition = Nutrition(from: schema, in: context)
        nutrition.recipe = recipe
        return nutrition
    }
    
    static func update(_ nutrition: Nutrition, from schema: NutritionSchema) {
        nutrition.calories = schema.calories
        nutrition.carbs = schema.carbs
        nutrition.protein = schema.protein
        nutrition.fat = schema.fat
        try? nutrition.managedObjectContext?.save()
    }
}
