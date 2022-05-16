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

        resetAllRecords(in: viewContext)
        fetchDataFromAPI(in: viewContext)
    
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
        
        try? readSeasonalsFromJson(in: viewContext)
        try? readRecipesFromJson(in: viewContext)
        try? readUsersFromJson(in: viewContext)
    
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
    
    static func resetAllRecords(in context: NSManagedObjectContext) {
        resetRecords(in: context, for: "Characteristic")
        resetRecords(in: context, for: "RecipeCategory")
        resetRecords(in: context, for: "Ingredient")
        resetRecords(in: context, for: "Preparation")
        resetRecords(in: context, for: "Nutrition")
        resetRecords(in: context, for: "Seasonal")
        resetRecords(in: context, for: "Recipe")
        resetRecords(in: context, for: "Collection")
        resetRecords(in: context, for: "User")
    }
    
    static func resetRecords(in context: NSManagedObjectContext, for entity: String) {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        _ = try? context.execute(deleteRequest)
        try? context.save()
    }
    
    static func fetchDataFromAPI(in context: NSManagedObjectContext) {
        let domainUrlString = "https://8c2a-2a02-810b-54c0-1690-d857-cc1d-8949-1bf4.ngrok.io"
        let seasonalUrl = URL(string: domainUrlString + "/api/seasonal")!
        let recipeUrl = URL(string: domainUrlString + "/api/recipe")!
        let userUrl = URL(string: domainUrlString + "/api/user")!

        URLSession.shared.dataTask(with: seasonalUrl) {data, res, err in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    _ = try decoder.decode([SeasonalSchema].self, from: data).map { Seasonal.create(from: $0, in: context) }
                } catch let error {
                    print(error.localizedDescription)
                    try? readSeasonalsFromJson(in: context)
                }
            }
        }.resume()
        
        URLSession.shared.dataTask(with: recipeUrl) {data, res, err in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    _ = try decoder.decode([RecipeSchema].self, from: data).map { Recipe.create(from: $0, in: context) }
                } catch let error {
                    print(error.localizedDescription)
                    try? readRecipesFromJson(in: context)
                }
            }
        }.resume()
        
        URLSession.shared.dataTask(with: userUrl) {data, res, err in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    _ = try decoder.decode([UserSchema].self, from: data).map { User.create(from: $0, in: context) }
                } catch let error {
                    print(error.localizedDescription)
                    try? readUsersFromJson(in: context)
                }
            }
        }.resume()
    }
    
    static func readSeasonalsFromJson(in context: NSManagedObjectContext) throws {
        if let seasonalsURL = Bundle.main.url(forResource: "Seasonals", withExtension: "json") {
            let data = try Data(contentsOf: seasonalsURL)
            let decoder = JSONDecoder()
            _ = try decoder.decode([SeasonalSchema].self, from: data).map { Seasonal.create(from: $0, in: context) }
        }
    }
    
    static func readRecipesFromJson(in context: NSManagedObjectContext) throws {
        if let recipesURL = Bundle.main.url(forResource: "Recipes", withExtension: "json") {
            let data = try Data(contentsOf: recipesURL)
            let decoder = JSONDecoder()
            _ = try decoder.decode([RecipeSchema].self, from: data).map { Recipe.create(from: $0, in: context) }
        }
    }
    
    static func readUsersFromJson(in context: NSManagedObjectContext) throws {
        if let usersURL = Bundle.main.url(forResource: "Users", withExtension: "json") {
            let data = try Data(contentsOf: usersURL)
            let decoder = JSONDecoder()
            _ = try decoder.decode([UserSchema].self, from: data).map { User.create(from: $0, in: context) }
        }
    }
}
