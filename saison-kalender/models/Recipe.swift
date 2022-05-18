//
//  Recipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData
import SwiftUI

@objc(Recipe)
public class Recipe: NSManagedObject {

    public convenience init(from schema: RecipeSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
        intro = schema.intro
        diets = schema.diets.map{ Diet(rawValue: $0) }.compactMap { $0 }
        categories = schema.categories.map { RecipeCategory.create(from: $0, in: context) }
        portions = Int(schema.portions)
        ingredients = schema.ingredients.map { Ingredient.create(from: $0, for: self, in: context) }
        preparations = schema.preparations.map { Preparation.create(from: $0, for: self, in: context) }
        seasonals = schema.seasonals.map({ Seasonal.with(name: $0, from: context) }).compactMap { $0 }
        if let nutritionSchema = schema.nutrition {
            nutrition = Nutrition.create(from: nutritionSchema, for: self, in: context)
        }
    }
}

extension Recipe: Representable {
    
    public var id: String { name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var diets: [Diet] {
        get { diets_?.map { Diet(rawValue: $0)! } ?? [] }
        set { diets_ = newValue.map { $0.rawValue } }
    }
    
    var portions: Int {
        get { Int(portions_) }
        set { portions_ = Int16(newValue) }
    }
    
    var ingredients: Array<Ingredient> {
        get { (ingredients_ as? Set<Ingredient>)?.sorted() ?? [] }
        set { ingredients_ = Set(newValue) as NSSet }
    }
    
    var seasonals: Array<Seasonal> {
        get { (seasonals_ as? Set<Seasonal>)?.sorted() ?? [] }
        set { seasonals_ = Set(newValue) as NSSet }
    }
    
    var preparations: Array<Preparation> {
        get { (preparations_ as? Set<Preparation>)?.sorted() ?? [] }
        set { preparations_ = Set(newValue) as NSSet }
    }
    
    var categories: Array<RecipeCategory> {
        get { (categories_ as? Set<RecipeCategory>)?.sorted() ?? [] }
        set { categories_ = Set(newValue) as NSSet }
    }
    
}

extension Recipe {
    
    var seasons: Set<Season> {
        var seasons_ = Set<Season>()
        for seasonal in seasonals {
            seasons_ = seasons_.union(seasonal.seasons)
        }
        return seasons_
    }
    
    var seasonal: Bool { seasons.contains(Season.current) }
    
    func seasonalsFor(_ season: Season) -> [Seasonal] {
        return seasonals.filter { $0.seasons.contains(season) }
    }
}

extension Recipe: Comparable {
    
    public static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id < rhs.id
    }
}

extension Recipe {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Recipe> {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(from schema: RecipeSchema, in context: NSManagedObjectContext) -> Recipe {
        let predicate = NSPredicate(format: "name_ = %@", schema.name)
        let recipes = (try? context.fetch(Recipe.fetchRequest(predicate))) ?? []
        if let recipe = recipes.first {
            update(recipe, from: schema)
            return recipe
        }
        return Recipe(from: schema, in: context)
    }
    
    static func update(_ recipe: Recipe, from schema: RecipeSchema) {
        recipe.intro = schema.intro
        recipe.diets = schema.diets.map{ Diet(rawValue: $0) }.compactMap { $0 }
        recipe.categories = schema.categories.map { RecipeCategory.create(from: $0, in: recipe.managedObjectContext!) }
        recipe.portions = Int(schema.portions)
        recipe.ingredients = schema.ingredients.map { Ingredient.create(from: $0, for: recipe, in: recipe.managedObjectContext!) }
        recipe.preparations = schema.preparations.map { Preparation.create(from: $0, for: recipe, in: recipe.managedObjectContext!) }
        recipe.seasonals = schema.seasonals.map({ Seasonal.with(name: $0, from: recipe.managedObjectContext!) }).compactMap { $0 }
        if let nutritionSchema = schema.nutrition {
            recipe.nutrition = Nutrition.create(from: nutritionSchema, for: recipe, in: recipe.managedObjectContext!)
        }
        try? recipe.managedObjectContext?.save()
    }
}
