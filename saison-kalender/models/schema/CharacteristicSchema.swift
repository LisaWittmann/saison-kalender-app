//
//  CharacteristicSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct CharacteristicSchema {
    var order: Int16
    var name: String
    var value: String
}

extension CharacteristicSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case order, name, value
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order = try values.decode(Int16.self, forKey: .order)
        name = try values.decode(String.self, forKey: .name)
        value = try values.decode(String.self, forKey: .value)
    }
}
