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
    
    var characteristics: Array<Characteristic> {
        get { (characteristics_ as? Set<Characteristic>)?.sorted() ?? [] }
        set { characteristics_ = Set(newValue) as NSSet }
    }
}

extension Seasonal: Representable {
    
    public var id: String { name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var slug: String {
        return name.replacingOccurrences(of: "ö", with: "oe")
            .replacingOccurrences(of: "ä", with: "ae")
            .replacingOccurrences(of: "ü", with: "ue")
            .replacingOccurrences(of: "ß", with: "ss")
            .replacingOccurrences(of: " ", with: "-")
            .lowercased()
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
}

extension Seasonal {
    
    static func create(name: String, seasons: [Season], in context: NSManagedObjectContext) -> Seasonal {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let seasonals = (try? context.fetch(Seasonal.fetchRequest(predicate))) ?? []
        if let seasonal = seasonals.first {
            seasonal.seasons = seasons
            try? context.save()
            return seasonal
        }
        let newSeasonal = Seasonal(context: context)
        newSeasonal.name = name
        newSeasonal.seasons = seasons
        try? context.save()
        return newSeasonal
    }
    
    func createCharacteristic(_ order: Int16, name: String, value: String) {
        let characteristic = Characteristic.create(name: name, value: value, order: order, seasonal: self, in: self.managedObjectContext!)
        self.characteristics.append(characteristic)
    }
}
