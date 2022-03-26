//
//  Seasonal.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

class Seasonal: RepresentableData {
    @Published var name: String
    @Published var seasons: [Month]
    
    init(name: String, seasons: [Month]) {
        self.name = name
        self.seasons = seasons
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    static func == (lhs: Seasonal, rhs: Seasonal) -> Bool {
        return lhs.name == rhs.name
    }
}
