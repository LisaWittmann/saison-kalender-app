//
//  IngredientSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct IngredientSchema {
    var name: String
    var quantity: Float
    var unit: String?
    var group: String?
}

extension IngredientSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, quantity, unit, group
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        quantity = try values.decode(Float.self, forKey: .quantity)
        unit = try values.decodeIfPresent(String.self, forKey: .unit)
        group = try values.decodeIfPresent(String.self, forKey: .group)
    }
}
