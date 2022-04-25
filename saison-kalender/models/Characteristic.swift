//
//  Characteristic.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

extension Characteristic: Representable {
    
    public var id: String { seasonal.name + name }
    
    var name: String {
        get { name_!}
        set { name_ = newValue}
    }
    
    var value: String {
        get { value_! }
        set { value_ = newValue }
    }
    
    var seasonal: Seasonal {
        get { seasonal_! }
        set { seasonal_ = newValue }
    }
}

extension Characteristic: Comparable {
    
    public static func < (lhs: Characteristic, rhs: Characteristic) -> Bool {
        return lhs.order < rhs.order
    }
    
}

extension Characteristic {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Characteristic> {
        let request = NSFetchRequest<Characteristic>(entityName: "Characteristic")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, value: String, order: Int16, seasonal: Seasonal, in context: NSManagedObjectContext) -> Characteristic {
        if let characteristic = seasonal.characteristics.filter { $0.order == order }.first {
            characteristic.name = name
            characteristic.value = value
            try? context.save()
            return characteristic
        }
        let characteristic = Characteristic(context: context)
        characteristic.name = name
        characteristic.value = value
        characteristic.order = order
        characteristic.seasonal = seasonal
        try? context.save()
        return characteristic
    }
}
