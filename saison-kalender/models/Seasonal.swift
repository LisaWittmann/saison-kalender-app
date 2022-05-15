//
//  Seasonal.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation
import CoreData

@objc(Seasonal)
public class Seasonal: NSManagedObject {
    
    public convenience init(from schema: SeasonalSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
        seasons_ = schema.seasons
        characteristics = schema.characteristics.map { Characteristic.create(from: $0, for: self, in: context) }
    }
}

extension Seasonal: Representable {
    
    public var id: String { name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var seasons: Array<Season> {
        get { seasons_?.map { Season(rawValue: $0)! } ?? [] }
        set { seasons_ = newValue.map { $0.rawValue } }
    }
    
    var recipes: Array<Recipe> {
        get { (recipes_ as? Set<Recipe>)?.sorted() ?? [] }
        set { recipes_ = Set(newValue) as NSSet }
    }
    
    var characteristics: Array<Characteristic> {
        get { (characteristics_ as? Set<Characteristic>)?.sorted() ?? [] }
        set { characteristics_ = Set(newValue) as NSSet }
    }
}

extension Seasonal: Comparable {
    
    public static func < (lhs: Seasonal, rhs: Seasonal) -> Bool {
        lhs.id < rhs.id
    }
}

extension Seasonal {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Seasonal> {
        let request = NSFetchRequest<Seasonal>(entityName: "Seasonal")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func with(name: String, from context: NSManagedObjectContext) -> Seasonal? {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let seasonals = (try? context.fetch(Seasonal.fetchRequest(predicate))) ?? []
        return seasonals.first
    }
    
    static func create(from schema: SeasonalSchema, in context: NSManagedObjectContext) -> Seasonal {
        if let seasonal = with(name: schema.name, from: context) {
            seasonal.seasons_ = schema.seasons
            seasonal.characteristics = schema.characteristics.map { Characteristic.create(from: $0, for: seasonal, in: context) }
            return seasonal
        }
        return Seasonal(from: schema, in: context)
    }
}
