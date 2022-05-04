//
//  SeasonalSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct SeasonalSchema {
    var name: String
    var seasons: [String]
    var characteristics: [CharacteristicSchema]
}

extension SeasonalSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case name, seasons, characteristics
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        seasons = (try? values.decode([String].self, forKey: .seasons)) ?? []
        characteristics = (try? values.decode([CharacteristicSchema].self, forKey: .characteristics)) ?? []
    }
}
