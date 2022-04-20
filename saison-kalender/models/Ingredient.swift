//
//  Ingredient.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import CoreData

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
    
    var slug: String {
        return name.replacingOccurrences(of: "ö", with: "oe")
            .replacingOccurrences(of: "ä", with: "ae")
            .replacingOccurrences(of: "ü", with: "ue")
            .replacingOccurrences(of: "ß", with: "ss")
            .replacingOccurrences(of: " ", with: "-")
            .lowercased()
    }
}

extension Ingredient: Comparable {
    
    public static func < (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id < rhs.id
    }
}

extension Ingredient {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Ingredient> {
        let request = NSFetchRequest<Ingredient>(entityName: "Ingredient")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension Ingredient {
    
    static func create(name: String, quanity: Float, unit: String? = nil, recipe: Recipe, in context: NSManagedObjectContext) -> Ingredient {
        if let ingredient = recipe.ingredients.filter({ $0.name == name }).first {
            ingredient.quantity = quanity
            ingredient.unit = unit
            try? context.save()
            return ingredient
        }
        let ingredient = Ingredient(context: context)
        ingredient.name = name
        ingredient.quantity = quanity
        ingredient.unit = unit
        ingredient.recipe = recipe
        try? context.save()
        return ingredient
    }
}

