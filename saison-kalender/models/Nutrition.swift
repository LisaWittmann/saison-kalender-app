//
//  Nutrition.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import CoreData

extension Nutrition {
    
    static func create(calories: Float, protein: Float, fat: Float, carbs: Float, recipe: Recipe?, in context: NSManagedObjectContext) -> Nutrition? {
        let nutrition = Nutrition(context: context)
        nutrition.id = UUID()
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
