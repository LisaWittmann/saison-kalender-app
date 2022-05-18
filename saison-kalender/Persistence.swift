//
//  Persistence.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import CoreData

struct PersistenceController {

    static var shared: PersistenceController = {
        let result = PersistenceController()
        let viewContext = result.container.viewContext
        
        try? result.readDataFromJson()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        try? result.readDataFromJson()
    
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "saison_kalender")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    func resetAllRecords(in context: NSManagedObjectContext) {
        resetRecords(for: "Characteristic")
        resetRecords(for: "RecipeCategory")
        resetRecords(for: "Ingredient")
        resetRecords(for: "Preparation")
        resetRecords(for: "Nutrition")
        resetRecords(for: "Seasonal")
        resetRecords(for: "Recipe")
        resetRecords(for: "Collection")
        resetRecords(for: "User")
    }
    
    func resetRecords(for entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        _ = try? container.viewContext.execute(deleteRequest)
        try? container.viewContext.save()
    }
    
    func readDataFromJson() throws {
        if let seasonalsURL = Bundle.main.url(forResource: "Seasonals", withExtension: "json") {
            let data = try Data(contentsOf: seasonalsURL)
            let decoder = JSONDecoder()
            _ = try decoder
                .decode([SeasonalSchema].self, from: data)
                .map { Seasonal.create(from: $0, in: container.viewContext) }
        }
        
        if let recipesURL = Bundle.main.url(forResource: "Recipes", withExtension: "json") {
            let data = try Data(contentsOf: recipesURL)
            let decoder = JSONDecoder()
            _ = try decoder
                .decode([RecipeSchema].self, from: data)
                .map { Recipe.create(from: $0, in: container.viewContext) }
        }
        
        if let usersURL = Bundle.main.url(forResource: "Users", withExtension: "json") {
            let data = try Data(contentsOf: usersURL)
            let decoder = JSONDecoder()
            _ = try decoder
                .decode([UserSchema].self, from: data)
                .map { User.create(from: $0, in: container.viewContext) }
        }
    }
}
