//
//  CategorySchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct RecipeCategorySchema {
    var name: String
}

extension RecipeCategorySchema: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
    }
}
