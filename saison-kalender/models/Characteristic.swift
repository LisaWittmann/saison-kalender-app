//
//  Characteristic.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

extension Characteristic {
    
    var name: String {
        get { name_!}
        set { name_ = newValue}
    }
    
    var value: String {
        get { value_! }
        set { value_ = newValue }
    }
}

extension Characteristic {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Characteristic> {
        let request = NSFetchRequest<Characteristic>(entityName: "Characteristic")
        request.sortDescriptors = [NSSortDescriptor(key: "seasonal", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, value: String, seasonal: Seasonal, in context: NSManagedObjectContext) -> Characteristic? {
        let characteristic = Characteristic(context: context)
        characteristic.id = UUID()
        characteristic.name = name
        characteristic.value = value
        characteristic.seasonal = seasonal
        do {
            try context.save()
        } catch {
            return nil
        }
        return characteristic
    }
}
