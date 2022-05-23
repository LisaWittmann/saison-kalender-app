//
//  CollectionSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct CollectionSchema {
    var name: String
    var recipes: [RecipeSchema]
}

extension CollectionSchema: Decodable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, recipes
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        recipes = try values.decodeIfPresent([RecipeSchema].self, forKey: .recipes) ?? []
    }
}
