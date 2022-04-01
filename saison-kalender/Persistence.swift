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
        
        let s2 = Seasonal(context: context)
        s2.name = "Radieschen"
        s2.seasons = [.März, .April]
        
        let s3 = Seasonal(context: context)
        s3.name = "Erdbeeren"
        s3.seasons = [.März, .April]
        
        let cat1 = RecipeCategory(context: context)
        cat1.name = "Frühstück"
        
        let cat2 = RecipeCategory(context: context)
        cat2.name = "Mittagsessen"
        
        let cat3 = RecipeCategory(context: context)
        cat3.name = "Abendessen"
        
        let cat4 = RecipeCategory(context: context)
        cat4.name = "Backen"
        
        let rec1 = Recipe.create(name: "Erdbeer Tarteletts", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec1?.addIngredient(name: "Erdbeeren", quantity: 500, unit: "g")
        rec1?.addIngredient(name: "Mehl", quantity: 1, unit: "kg")
        rec1?.addNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec1?.addToCategories_(cat4)
        rec1?.addToSeasonals_(s3)
        
        let rec2 = Recipe.create(name: "Linguine mit Mangold", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec2?.addIngredient(name: "Mangold", quantity: 1)
        rec2?.addIngredient(name: "Linguine", quantity: 500, unit: "g")
        rec2?.addIngredient(name: "Sahne", quantity: 250, unit: "ml")
        rec2?.addNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec2?.addToCategories_(cat2)
        rec2?.addToCategories_(cat3)
        rec2?.addToCategories_(cat1)
        rec2?.addToCategories_(cat4)
        rec2?.addToSeasonals_(s1)
        rec2?.addPreparation(title: "Wasser kochen", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.")
        rec2?.addPreparation(title: "Mangold dünsten", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.")
        
        let rec3 = Recipe.create(name: "Mangold Pfanne", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec3?.addIngredient(name: "Mangold", quantity: 1)
        rec3?.addIngredient(name: "Tomaten", quantity: 500, unit: "g")
        rec3?.addIngredient(name: "Sahne", quantity: 250, unit: "ml")
        rec3?.addNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec3?.addToCategories_(cat2)
        rec3?.addToCategories_(cat3)
        rec3?.addToSeasonals_(s1)
        rec3?.addPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Tipp: Lorem Ipsum")
        rec3?.addPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.")
        
        let rec4 = Recipe.create(name: "Mangold Salat", intro: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", in: context)
        rec4?.addIngredient(name: "Mangold", quantity: 1)
        rec4?.addIngredient(name: "Radieschen", quantity: 100, unit: "g")
        rec4?.addIngredient(name: "Joghurt Dressing", quantity: 50, unit: "ml")
        rec4?.addNutrition(calories: 555, protein: 67, fat: 0.6, carbs: 2.5)
        rec4?.addToCategories_(cat2)
        rec4?.addToCategories_(cat3)
        rec4?.addToSeasonals_(s1)
        rec4?.addToSeasonals_(s2)
        rec4?.addPreparation(title: "Lorem Ipsum", text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Vorsicht: Lorem Ipsum")
        rec4?.addPreparation(text: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.", info: "Servier Tipp: Lorem Ipsum")
        
        let c1 = Collection(context: context)
        c1.name = "April Favoriten"
        c1.addToRecipes_(rec1!)
        c1.addToRecipes_(rec2!)
        c1.addToRecipes_(rec3!)
        c1.user = u1
        
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
