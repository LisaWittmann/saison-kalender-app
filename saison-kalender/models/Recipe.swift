//
//  Recipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

extension Recipe {
    
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

extension Recipe: Representable {
    
    public var id: String { name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
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

extension Recipe: Comparable {
    
    public static func < (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id < rhs.id
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
    
    func seasonalsFor(_ season: Season) -> [Seasonal] {
        return seasonals.filter({ $0.seasons.contains(season) })
    }
}


extension Recipe {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Recipe> {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
}
    
extension Recipe {
    
    static func create(name: String, intro: String? = nil, in context: NSManagedObjectContext) -> Recipe {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let recipes = (try? context.fetch(Recipe.fetchRequest(predicate))) ?? []
        if let recipe = recipes.first {
            recipe.intro = intro
            try? context.save()
            return recipe
        }
        let newRecipe = Recipe(context: context)
        newRecipe.name = name
        newRecipe.intro = intro
        try? context.save()
        return newRecipe
    }
    
    func createPreparation(title: String? = nil, text: String, info: String? = nil, order: Int16) {
        let preparation = Preparation.create(order, title: title, text: text, info: info, recipe: self, in: self.managedObjectContext!)
        self.preparations.append(preparation)
    }
    
    func createNutrition(calories: Float, protein: Float, fat: Float, carbs: Float) {
        self.nutrition = Nutrition.create(calories: calories, protein: protein, fat: fat, carbs: carbs, recipe: self, in: self.managedObjectContext!)
    }
    
    func createIngredient(name: String, quantity: Float, unit: String? = nil) {
        let ingredient = Ingredient.create(name: name, quanity: quantity, unit: unit, recipe: self, in: self.managedObjectContext!)
        self.ingredients.append(ingredient)
    }
}
