//
//  User.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

extension User {
    
    var diets: [Diet] {
        get { diets_?.map { Diet(rawValue: $0)! } ?? [] }
        set { diets_ = newValue.map { $0.rawValue } }
    }
    
    var favorites: Set<Recipe> {
        get { (favorites_ as? Set<Recipe>) ?? [] }
        set { favorites_ = newValue as NSSet }
    }
    
    var collections: Array<Collection> {
        get { (collections_ as? Set<Collection>)?.sorted() ?? [] }
        set { collections_ = Set(newValue) as NSSet }
    }
}

extension User: Representable {
    
    public var id: String { name }
    
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
}

extension User: Comparable {
    
    public static func < (lhs: User, rhs: User) -> Bool {
        lhs.id < rhs.id
    }
}

extension User {
    
    static func fetchRequest(_ predicate: NSPredicate?) -> NSFetchRequest<User> {
        let request = NSFetchRequest<User>(entityName: "User")
        request.sortDescriptors = [NSSortDescriptor(key: "name_", ascending: true)]
        request.predicate = predicate
        return request
    }
}
 
extension User {
    
    static func create(name: String, email: String, password: String, in context: NSManagedObjectContext) -> User {
        let predicate = NSPredicate(format: "email_ = %@", email)
        let users = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        if let user = users.first {
            return user
        }
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        try? context.save()
        return newUser
    }
    
    static func with(email: String, password: String, from context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "email_ = %@ AND password_ = %@", email, password)
        let matchingUsers = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        return matchingUsers.first
    }
    
    static func with(email: String, from context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "email_ = %@", email)
        let matchingUsers = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        return matchingUsers.first
    }
}
