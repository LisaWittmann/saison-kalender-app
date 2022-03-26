//
//  Recipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

enum Category: String, CaseIterable {
    case Frühstück, Mittagessen, Abendessen, Snacks, Salate, Beilagen, Suppen, Backen
}

enum Unit: String, CaseIterable {
    case MG, G, KG, ML, L, EL, TL
}

class Ingredient {
    var quantity: Double
    var unit: Unit
    var name: String
    
    init(quantity: Double, unit: Unit, name: String) {
        self.quantity = quantity
        self.unit = unit
        self.name = name
    }
}

class Preparation {
    var title: String?
    var description: String
    var addition: String?
    
    init(description: String, title: String?, addition: String?) {
        self.description = description
        self.title = title
        self.addition = addition
    }
}

class Nutrition {
    var calories: Int
    var carbs: Double
    var protein: Double
    var fat: Double
    
    init(calories: Int, carbs: Double, protein: Double, fat: Double) {
        self.calories = calories
        self.carbs = carbs
        self.protein = protein
        self.fat = fat
    }
}

class Recipe: RepresentableData {
    @Published var name: String
    @Published var seasonals: [Seasonal]
    
    @Published var ingredients: [Ingredient]
    @Published var preparations: [Preparation]
    @Published var categories: [Category]
    @Published var nutrition: Nutrition?
    
    var id = UUID()
    
    init(
        name: String,
        seasonals: [Seasonal],
        ingredients: [Ingredient],
        preparations: [Preparation],
        categories: [Category],
        nutrition: Nutrition?
    ) {
        self.name = name
        self.seasonals = seasonals
        self.ingredients = ingredients
        self.preparations = preparations
        self.categories = categories
        self.nutrition = nutrition
    }
    
    func isSeasonal(in month: Month) -> Bool {
        for seasonal in self.seasonals {
            if (seasonal.seasons.contains(month)) {
                return true
            }
        }
        return false
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
    }
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
