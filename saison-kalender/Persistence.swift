//
//  Persistence.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 26.03.22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        initTestValues(context: viewContext)
    
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()
    
    static func initTestValues(context: NSManagedObjectContext) {
        let u1 = User.create(name: "Lisa", email: "lisa@mail.de", password: "test", in: context)
        
        let s1 = Seasonal(context: context)
        s1.name = "Mangold"
        s1.seasons = [.März, .April]
        _ = Characteristic.create(name: "Wissenswertes", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 1, seasonal: s1, in: context)
        _ = Characteristic.create(name: "Ernte", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 2, seasonal: s1, in: context)
        _ = Characteristic.create(name: "Anbau", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 3, seasonal: s1, in: context)
        
        let s2 = Seasonal(context: context)
        s2.name = "Radieschen"
        s2.seasons = [.März, .April]
        _ = Characteristic.create(name: "Wissenswertes", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 3, seasonal: s2, in: context)
        _ = Characteristic.create(name: "Ernte", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 2, seasonal: s2, in: context)
        
        let s3 = Seasonal(context: context)
        s3.name = "Erdbeeren"
        s3.seasons = [.März, .April]
        _ = Characteristic.create(name: "Wissenswertes", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 1, seasonal: s3, in: context)
        _ = Characteristic.create(name: "Ernte", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 2, seasonal: s3, in: context)
        _ = Characteristic.create(name: "Anbau", value: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 3, seasonal: s3, in: context)
        
        let cat1 = RecipeCategory(context: context)
        cat1.name = "Frühstück"
        
        let cat2 = RecipeCategory(context: context)
        cat2.name = "Mittagsessen"
        
        let cat3 = RecipeCategory(context: context)
        cat3.name = "Abendessen"
        
        let cat4 = RecipeCategory(context: context)
        cat4.name = "Backen"
        
        let rec1 = Recipe.create(name: "Erdbeer Tarteletts", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec1?.createIngredient(name: "Erdbeeren", quantity: 500, unit: "g")
        rec1?.createIngredient(name: "Mehl", quantity: 1, unit: "kg")
        rec1?.createNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec1?.addToCategories_(cat4)
        rec1?.addToSeasonals_(s3)
        
        let rec2 = Recipe.create(name: "Linguine mit Mangold", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec2?.createIngredient(name: "Mangold", quantity: 1)
        rec2?.createIngredient(name: "Linguine", quantity: 500, unit: "g")
        rec2?.createIngredient(name: "Sahne", quantity: 250, unit: "ml")
        rec2?.createNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec2?.addToCategories_(cat2)
        rec2?.addToCategories_(cat3)
        rec2?.addToCategories_(cat1)
        rec2?.addToCategories_(cat4)
        rec2?.addToSeasonals_(s1)
        rec2?.createPreparation(title: "Wasser kochen", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 1)
        rec2?.createPreparation(title: "Mangold dünsten", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 2)
        
        let rec3 = Recipe.create(name: "Mangold Pfanne", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec3?.createIngredient(name: "Mangold", quantity: 1)
        rec3?.createIngredient(name: "Tomaten", quantity: 500, unit: "g")
        rec3?.createIngredient(name: "Sahne", quantity: 250, unit: "ml")
        rec3?.createNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec3?.addToCategories_(cat2)
        rec3?.addToCategories_(cat3)
        rec3?.addToSeasonals_(s1)
        rec3?.createPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Tipp: Lorem Ipsum", order: 1)
        rec3?.createPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", order: 2)
        
        let rec4 = Recipe.create(name: "Mangold Salat", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec4?.createIngredient(name: "Mangold", quantity: 1)
        rec4?.createIngredient(name: "Radieschen", quantity: 100, unit: "g")
        rec4?.createIngredient(name: "Joghurt Dressing", quantity: 50, unit: "ml")
        rec4?.createNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec4?.addToCategories_(cat2)
        rec4?.addToCategories_(cat3)
        rec4?.addToSeasonals_(s1)
        rec4?.addToSeasonals_(s2)
        rec4?.createPreparation(title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Vorsicht: Lorem Ipsum", order: 1)
        rec4?.createPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Servier Tipp: Lorem Ipsum", order: 2)
        
        let col1 = Collection(context: context)
        col1.name = "April Favoriten"
        col1.addToRecipes_(rec1!)
        col1.addToRecipes_(rec2!)
        col1.addToRecipes_(rec3!)
        col1.user = u1!
        
        u1?.addToFavorites_(rec1!)
        u1?.addToFavorites_(rec2!)
        u1?.addToFavorites_(rec3!)
    }

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "saison_kalender")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
