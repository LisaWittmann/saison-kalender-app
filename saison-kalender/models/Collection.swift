//
//  Collection.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

class Collection: RepresentableData {
    var id = UUID()
    
    @Published var name: String
    @Published var recipes: Set<Recipe>
    
    init(name: String, recipes: Set<Recipe>) {
        self.name = name
        self.recipes = recipes
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(recipes)
    }
    
    static func == (lhs: Collection, rhs: Collection) -> Bool {
        return lhs.id == rhs.id
    }
}
