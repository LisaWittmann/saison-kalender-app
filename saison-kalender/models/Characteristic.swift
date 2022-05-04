//
//  Characteristic.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation
import CoreData

@objc(Characteristic)
public class Characteristic: NSManagedObject {
    
    public convenience init(from schema: CharacteristicSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        order = schema.order
        name = schema.name
        value = schema.value
    }
}

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
}

extension Characteristic {
    
    static func create(from schema: CharacteristicSchema, for seasonal: Seasonal, in context: NSManagedObjectContext) -> Characteristic {
        if let characteristic = seasonal.characteristics.filter({ $0.order == schema.order }).first {
            characteristic.name = schema.name
            characteristic.value = schema.value
            try? context.save()
            return characteristic
        }
        let characteristic = Characteristic(from: schema, in: context)
        characteristic.seasonal = seasonal
        return characteristic
    }
}
