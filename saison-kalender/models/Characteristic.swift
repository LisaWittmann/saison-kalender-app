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
        if lhs.seasonal == rhs.seasonal {
            return lhs.order < rhs.order
        }
        return lhs.seasonal < rhs.seasonal
    }
}

extension Characteristic {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<Characteristic> {
        let request = NSFetchRequest<Characteristic>(entityName: "Characteristic")
        request.sortDescriptors = [NSSortDescriptor(key: "order", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(from schema: CharacteristicSchema, for seasonal: Seasonal, in context: NSManagedObjectContext) -> Characteristic {
        if let characteristic = seasonal.characteristics.filter({ $0.order == schema.order }).first {
            update(characteristic, from: schema)
            return characteristic
        }
        let characteristic = Characteristic(from: schema, in: context)
        characteristic.seasonal = seasonal
        return characteristic
    }
    
    static func update(_ characteristic: Characteristic, from schema: CharacteristicSchema) {
        characteristic.name = schema.name
        characteristic.value = schema.value
        try? characteristic.managedObjectContext?.save()
    }
}
