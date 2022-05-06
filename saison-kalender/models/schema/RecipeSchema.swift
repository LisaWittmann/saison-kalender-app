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
    var ingredients: [IngredientSchema]
    var preparations: [PreparationSchema]
    var seasonals: [String]
}

extension RecipeSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, intro, diets, categories, nutrition, ingredients, preparations, seasonals
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        intro = (try? values.decode(String.self, forKey: .intro)) ?? nil
        nutrition = (try? values.decode(NutritionSchema.self, forKey: .nutrition)) ?? nil
        diets = (try? values.decode([String].self, forKey: .diets)) ?? []
        categories = (try? values.decode([RecipeCategorySchema].self, forKey: .categories)) ?? []
        ingredients = (try? values.decode([IngredientSchema].self, forKey: .ingredients)) ?? []
        preparations = (try? values.decode([PreparationSchema].self, forKey: .preparations)) ?? []
        seasonals = (try? values.decode([String].self, forKey: .seasonals)) ?? []
    }
}
