//
//  Seasonal.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
import CoreData

extension Seasonal {
    
    var seasons: [Season] {
        get { seasons_?.map({ Season(rawValue: $0)! }) ?? [] }
        set { seasons_ = newValue.map({ $0.rawValue }) }
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

extension Seasonal {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Seasonal> {
        let request = NSFetchRequest<Seasonal>(entityName: "Seasonal")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, seasons: [Season], recipe: Recipe?, in context: NSManagedObjectContext) -> Seasonal? {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let seasonals = (try? context.fetch(Seasonal.fetchRequest(predicate))) ?? []
        if seasonals.first != nil {
            return nil
        }
        let newSeasonal = Seasonal(context: context)
        newSeasonal.name = name
        newSeasonal.seasons = seasons
        do {
            try context.save()
        } catch {
            return nil
        }
        return newSeasonal
    }
}

extension Seasonal {
    
    func inSeason(_ season: Season) -> Bool {
        return self.seasons.contains(season)
    }
    
    static func current(from context: NSManagedObjectContext) -> [Seasonal] {
        let seasonals: [Seasonal] = (try? context.fetch(Seasonal.fetchRequest())) ?? []
        return seasonals.filter({ $0.inSeason(Season.current) })
    }
}
