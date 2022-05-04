//
//  Category.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

@objc(RecipeCategory)
public class RecipeCategory: NSManagedObject {
    
    public convenience init(from schema: RecipeCategorySchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
    }
}

extension RecipeCategory {
    
    var recipes: Set<Recipe> {
        get { (recipes_ as? Set<Recipe>) ?? [] }
        set { recipes_ = newValue as NSSet }
    }
}

extension RecipeCategory: Representable {
    
    public var id: String { name }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
}

extension RecipeCategory: Comparable {
    
    public static func < (lhs: RecipeCategory, rhs: RecipeCategory) -> Bool {
        lhs.id < rhs.id
    }
}

extension RecipeCategory {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<RecipeCategory> {
        let request = NSFetchRequest<RecipeCategory>(entityName: "RecipeCategory")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
}

extension RecipeCategory {
    
    static func create(from schema: RecipeCategorySchema, in context: NSManagedObjectContext) -> RecipeCategory {
        let predicate = NSPredicate(format: "name_ = %@", schema.name)
        let categories = (try? context.fetch(RecipeCategory.fetchRequest(predicate))) ?? []
        if let category = categories.first {
            return category
        }
        let newCategory = RecipeCategory(from: schema, in: context)
        return newCategory
        
    }
}
