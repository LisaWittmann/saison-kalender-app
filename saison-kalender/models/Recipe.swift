//
//  Recipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

extension Recipe {
    
    var ingredients: Set<Ingredient> {
        get { (ingredients_ as? Set<Ingredient>) ?? [] }
        set { ingredients_ = newValue as NSSet }
    }
    
    var seasonals: Set<Seasonal> {
        get { (seasonals_ as? Set<Seasonal>) ?? [] }
        set { seasonals_ = newValue as NSSet }
    }
    
    var preparations: Set<Preparation> {
        get { (preparations_ as? Set<Preparation>) ?? [] }
        set { preparations_ = newValue as NSSet }
    }
    
    var categories: Set<RecipeCategory> {
        get { (categories_ as? Set<RecipeCategory>) ?? [] }
        set { categories_ = newValue as NSSet }
    }
}

extension Recipe: Representable {
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    public var id: String { name }
}

extension Recipe {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Recipe> {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, intro: String? = nil, in context: NSManagedObjectContext) -> Recipe? {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let recipes = (try? context.fetch(Recipe.fetchRequest(predicate))) ?? []
        if recipes.first != nil {
            return nil
        }
        let newRecipe = Recipe(context: context)
        newRecipe.name = name
        newRecipe.intro = intro
        do {
            try context.save()
        } catch {
            return nil
        }
        return newRecipe
    }
    
    func addPreparation(title: String? = nil, text: String, info: String? = nil) {
        let preparation = Preparation.create(title: title, text: text, info: info, recipe: self, in: self.managedObjectContext!)
        if preparation != nil {
            self.preparations.insert(preparation!)
        }
    }
    
    func addNutrition(calories: Float, protein: Float, fat: Float, carbs: Float) {
        self.nutrition = Nutrition.create(calories: calories, protein: protein, fat: fat, carbs: carbs, recipe: self, in: self.managedObjectContext!)
    }
    
    func addIngredient(name: String, quantity: Float, unit: String? = nil) {
        let ingredient = Ingredient.create(name: name, quanity: quantity, unit: unit, recipe: self, in: self.managedObjectContext!)
        if ingredient != nil {
            self.ingredients.insert(ingredient!)
        }
    }
}

extension Recipe {
    
    private var seasons: Set<Season> {
        var seasons_ = Set<Season>()
        for seasonal in seasonals {
            seasons_ = seasons_.union(seasonal.seasons)
        }
        return seasons_
    }
    
    func isSeasonal() -> Bool {
        return seasons.contains(Season.current)
    }
    
    func seasonalsFor(season: Season) -> [Seasonal] {
        return seasonals.filter({ $0.inSeason(season) })
    }

    static func inSeason(season: Season, context: NSManagedObjectContext) -> [Recipe] {
        let recipes: [Recipe] = (try? context.fetch(Recipe.fetchRequest())) ?? []
        return recipes.filter({ $0.seasons.contains(season) })
    }
    
    static func current(from context: NSManagedObjectContext) -> [Recipe] {
        return Recipe.inSeason(season: Season.current, context: context)
    }
}
