//
//  RecipeSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct RecipeSchema {
    var name: String
    var intro: String?
    var diets: [String]
    var categories: [RecipeCategorySchema]
    var nutrition: NutritionSchema?
    var portions: Int16
    var ingredients: [IngredientSchema]
    var preparations: [PreparationSchema]
    var seasonals: [String]
}

extension RecipeSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, intro, diets, categories, nutrition, portions, ingredients, preparations, seasonals
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        intro = try values.decodeIfPresent(String.self, forKey: .intro)
        nutrition = try values.decodeIfPresent(NutritionSchema.self, forKey: .nutrition)
        diets = try values.decodeIfPresent([String].self, forKey: .diets) ?? []
        categories = try values.decodeIfPresent([RecipeCategorySchema].self, forKey: .categories) ?? []
        portions = try values.decodeIfPresent(Int16.self, forKey: .portions) ?? 4
        ingredients = try values.decodeIfPresent([IngredientSchema].self, forKey: .ingredients) ?? []
        preparations = try values.decodeIfPresent([PreparationSchema].self, forKey: .preparations) ?? []
        seasonals = try values.decodeIfPresent([String].self, forKey: .seasonals) ?? []
    }
}
