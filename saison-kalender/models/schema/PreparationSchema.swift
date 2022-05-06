//
//  PreparationSchema.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import Foundation

public struct PreparationSchema {
    var order: Int16
    var title: String?
    var text: String
    var info: String?
}

extension PreparationSchema: Decodable {
    
    enum CodingKeys: String, CodingKey, CaseIterable {
        case order, title, text, info
    }
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        order = try values.decode(Int16.self, forKey: .order)
        text = try values.decode(String.self, forKey: .text)
        title = (try? values.decode(String.self, forKey: .title)) ?? nil
        info = (try? values.decode(String.self, forKey: .info)) ?? nil
    }
}
