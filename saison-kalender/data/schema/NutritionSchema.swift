//
//  NutritionSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct NutritionSchema {
    var calories: Float
    var carbs: Float
    var protein: Float
    var fat: Float
}

extension NutritionSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case calories, carbs, protein, fat
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        calories = try values.decode(Float.self, forKey: .calories)
        carbs = try values.decode(Float.self, forKey: .carbs)
        protein = try values.decode(Float.self, forKey: .protein)
        fat = try values.decode(Float.self, forKey: .fat)
    }
}
