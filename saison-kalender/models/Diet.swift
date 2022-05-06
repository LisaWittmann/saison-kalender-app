//
//  Diet.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.04.22.
//

import Foundation

enum Diet: String, CaseIterable {

    var name: String { rawValue }
    
    case GlutenFree = "Glutenfrei", DairyFree = "Laktosefrei", Vegetarian = "Vegetarisch", Vegan = "Vegan"
}
