//
//  Recipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
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
    
    var categories: Set<Category> {
        get { (categories_ as? Set<Category>) ?? [] }
        set { categories_ = newValue as NSSet }
    }
}

extension Recipe {
    
    private var seasons: Set<Season> {
        get {
            var seasons_ = Set<Season>()
            for seasonal in seasonals {
                seasons_ = seasons_.union(seasonal.seasons)
            }
            return seasons_
        }
    }
    
    func isInSeason(_ season: Season) -> Bool {
        return seasons.contains(season)
    }
    
    static func forSeason(season: Season, context: NSManagedObjectContext) -> [Recipe] {
        let request = NSFetchRequest<Recipe>(entityName: "Recipe")
        let recipes = (try? context.fetch(request)) ?? []
        var seasonalRecipes: [Recipe] = []
        for recipe in recipes {
            if recipe.isInSeason(season) {
                seasonalRecipes.append(recipe)
            }
        }
        return seasonalRecipes
    }
    
    static func current(context: NSManagedObjectContext) -> [Recipe] {
        return Recipe.forSeason(season: Season.current(context: context), context: context)
    }
}

extension Recipe: Representable {
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    public var id: String { name }
}
