//
//  Season.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
import CoreData
import UIKit

extension Season {
    
    var seasonals: Set<Seasonal> {
        get { (seasonals_ as? Set<Seasonal>) ?? [] }
        set { seasonals_ = newValue as NSSet }
    }
}

extension Season: Representable {
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var month: Int {
        get { month_ as! Int }
        set { month_ = newValue as NSNumber}
    }
    
    public var id: Int { month }
}

extension Season {
    
    static func current(context: NSManagedObjectContext) -> Season {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let request = NSFetchRequest<Season>(entityName: "Season")
        request.predicate = NSPredicate(format: "month_ = %i", currentMonth)
        let seasons = (try? context.fetch(request)) ?? []
        return seasons.first!
    }
    
    static func with(name: String, month: Int, context: NSManagedObjectContext) -> Season {
        let request = NSFetchRequest<Season>(entityName: "Season")
        request.predicate = NSPredicate(format: "month_ = %i", month)
        let seasons = (try? context.fetch(request)) ?? []
        if let season = seasons.first {
            return season
        }
        let season = Season(context: context)
        season.month = month
        season.name = name
        try? context.save()
        return season
    }
}
