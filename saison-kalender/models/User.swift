//
//  User.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

extension User {
    
    var favorites: Set<Recipe> {
        get { (favorites_ as? Set<Recipe>) ?? [] }
        set { favorites_ = newValue as NSSet }
    }
    
    var collections: Set<Collection> {
        get { (collections_ as? Set<Collection>) ?? [] }
        set { collections_ = newValue as NSSet }
    }
}

extension User: Representable {
    
    var email: String {
        get { email_! }
        set { email_ = newValue }
    }
    
    var name: String {
        get { name_! }
        set { name_ = newValue }
    }
    
    var password: String {
        get { password_! }
        set { password_ = newValue }
    }
    
    public var id: String { name }
}

extension User {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<User> {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static func create(name: String, email: String, password: String, in context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "name_ = %@", name)
        let users = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        if users.first != nil {
            return nil
        }
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return newUser
    }
    
    static func getBy(name: String, password: String, from context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "name_ = %@ AND password_ = %@", name, password)
        let matchingUsers = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        return matchingUsers.first
    }
}

extension User {
    
    func favor(recipe: Recipe) {
        favorites.insert(recipe)
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        favor(recipe: recipe)
        collection.recipes.insert(recipe)
    }
        
    func remove(recipe: Recipe, from collection: Collection) {
        if (collection.recipes.contains(recipe)) {
            collection.recipes.remove(recipe)
        }
    }
        
    func remove(recipe: Recipe) {
        for collection in self.collections {
            remove(recipe: recipe, from: collection)
        }
        favorites.remove(recipe)
    }
        
    func remove(collection: Collection) {
        self.collections.remove(collection)
    }
}


