//
//  Ingredient.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import CoreData

@objc(Ingredient)
public class Ingredient: NSManagedObject {
    
    public convenience init(from schema: IngredientSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
        quantity = schema.quantity
        unit = schema.unit
        group = schema.group
    }
}

extension Ingredient: Representable {

    public var id: String { recipe.name + name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var recipe: Recipe {
        get { recipe_! }
        set { recipe_ = newValue }
    }
}

extension Ingredient: Comparable {
    
    public static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        if lhs.recipe == rhs.recipe {
            return lhs.id < rhs.id
        }
        return lhs.recipe < rhs.recipe
    }
}

extension Ingredient {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Ingredient> {
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(from schema: IngredientSchema, for recipe: Recipe, in context: NSManagedObjectContext) -> Ingredient {
        if let ingredient = recipe.ingredients.filter({ $0.name == schema.name }).first {
            ingredient.quantity = schema.quantity
            ingredient.unit = schema.unit
            ingredient.group = schema.group
            try? context.save()
            return ingredient
        }
        let ingredient = Ingredient(from: schema, in: context)
        ingredient.recipe = recipe
        try? context.save()
        return ingredient
    }
}
