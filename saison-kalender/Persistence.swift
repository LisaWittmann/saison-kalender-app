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
        let january = Season(context: context)
        january.name = "Januar"
        january.month = 1
        
        let february = Season(context: context)
        february.name = "February"
        february.month = 2
        
        let march = Season(context: context)
        march.name = "März"
        march.month = 3
        
        let april = Season(context: context)
        april.name = "April"
        april.month = 4
        
        let may = Season(context: context)
        may.name = "Mai"
        may.month = 5
        
        let june = Season(context: context)
        june.name = "Juni"
        june.month = 6
        
        let july = Season(context: context)
        july.name = "July"
        july.month = 7
        
        let august = Season(context: context)
        august.name = "August"
        august.month = 8
        
        let september = Season(context: context)
        september.name = "September"
        september.month = 9
        
        let october = Season(context: context)
        october.name = "Oktober"
        october.month = 10
        
        let november = Season(context: context)
        november.name = "November"
        november.month = 11
        
        let december = Season(context: context)
        december.name = "Dezember"
        december.month = 12
        
        let s1 = Seasonal(context: context)
        s1.name = "Mangold"
        s1.addToSeasons_(march)
        s1.addToSeasons_(april)
        
        let s2 = Seasonal(context: context)
        s2.name = "Radieschen"
        s2.addToSeasons_(march)
        s2.addToSeasons_(april)
        
        let s3 = Seasonal(context: context)
        s3.name = "Erdbeeren"
        s3.addToSeasons_(march)
        s3.addToSeasons_(april)
        
        let cat1 = Category(context: context)
        cat1.name = "Frühstück"
        
        let cat2 = Category(context: context)
        cat2.name = "Mittagsessen"
        
        let cat3 = Category(context: context)
        cat3.name = "Abendessen"
        
        let cat4 = Category(context: context)
        cat4.name = "Backen"
        
        let rec1 = Recipe(context: context)
        rec1.name = "Erdbeer Tarteletts"
        rec1.intro = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        rec1.addToCategories_(cat4)
        rec1.addToSeasonals_(s3)
        
        let ing1 = Ingredient(context: context)
        ing1.name = "Erdbeeren"
        ing1.quantity = 500
        ing1.unit = "g"
        ing1.recipe = rec1
        
        let ing2 = Ingredient(context: context)
        ing2.name = "Mehl"
        ing2.quantity = 1
        ing2.unit = "kg"
        ing2.recipe = rec1
        
        let nut1 = Nutrition(context: context)
        nut1.calories = 555
        nut1.carbs = 67
        nut1.fat = 0.6
        nut1.protein = 2.5
        nut1.recipe = rec1
        
        let rec2 = Recipe(context: context)
        rec2.name = "Linguine mit Mangold"
        rec2.intro = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        rec2.addToCategories_(cat2)
        rec2.addToCategories_(cat3)
        rec2.addToSeasonals_(s1)
        
        let ing3 = Ingredient(context: context)
        ing3.name = "Mangold"
        ing3.quantity = 1
        ing3.recipe = rec2
        
        let ing4 = Ingredient(context: context)
        ing4.name = "Linguine"
        ing4.quantity = 500
        ing4.unit = "g"
        ing4.recipe = rec2
        
        let ing5 = Ingredient(context: context)
        ing5.name = "Sahne"
        ing5.quantity = 250
        ing5.unit = "ml"
        ing5.recipe = rec2
        
        let nut2 = Nutrition(context: context)
        nut2.calories = 555
        nut2.carbs = 67
        nut2.fat = 0.6
        nut2.protein = 2.5
        nut2.recipe = rec2
        
        let prep1 = Preparation(context: context)
        prep1.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        prep1.recipe = rec2
        
        let prep2 = Preparation(context: context)
        prep1.text = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus."
        prep2.recipe = rec2
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
