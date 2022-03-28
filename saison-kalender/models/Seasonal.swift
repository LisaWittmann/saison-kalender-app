//
//  Seasonal.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
import CoreData

extension Seasonal {
    
    var seasons: Set<Season> {
        get { (seasons_ as? Set<Season>) ?? [] }
        set { seasons_ = newValue as NSSet }
    }
    
    var recipes: Set<Recipe> {
        get { (recipes_ as? Set<Recipe>) ?? [] }
        set { recipes_ = newValue as NSSet }
    }
}

extension Seasonal: Representable {
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    public var id: String { name }
}
