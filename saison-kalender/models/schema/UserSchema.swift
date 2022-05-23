//
//  UserSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct UserSchema {
    var name: String
    var email: String
    var password: String
    var diets: [String]
    var favorites: [RecipeSchema]
    var collections: [CollectionSchema]
}

extension UserSchema: Decodable {
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, email, password, diets, favorites, collections
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        email = try values.decode(String.self, forKey: .email)
        password = try values.decode(String.self, forKey: .password)
        diets = try values.decodeIfPresent([String].self, forKey: .diets) ?? []
        favorites = try values.decodeIfPresent([RecipeSchema].self, forKey: .favorites) ?? []
        collections = try values.decodeIfPresent([CollectionSchema].self,forKey: .collections) ?? []
    }
}

