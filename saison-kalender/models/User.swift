//
//  User.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import CoreData

@objc(User)
public class User: NSManagedObject {

    public convenience init(from schema: UserSchema, in context: NSManagedObjectContext) {
        self.init(context: context)
        name = schema.name
        email = schema.email
        password = schema.password
        diets = schema.diets.map({ Diet(rawValue: $0) }).compactMap { $0 }
        favorites = schema.favorites.map { Recipe.create(from: $0, in: context) }
        collections = schema.collections.map { Collection.create(from: $0, for: self, in: context) }
    }
}

extension User: Representable {
    
    public var id: String { email }
    
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
    
    var diets: [Diet] {
        get { diets_?.map({ Diet(rawValue: $0) }).compactMap { $0 } ?? [] }
        set { diets_ = newValue.map { $0.rawValue } }
    }
    
    var favorites: Array<Recipe> {
        get { (favorites_ as? Set<Recipe>)?.sorted() ?? [] }
        set { favorites_ = Set(newValue) as NSSet }
    }
    
    var collections: Array<Collection> {
        get { (collections_ as? Set<Collection>)?.sorted() ?? [] }
        set { collections_ = Set(newValue) as NSSet }
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
    
    static func with(email: String, from context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "email_ = %@", email)
        let matchingUsers = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        return matchingUsers.first
    }
    
    static func with(email: String, password: String, from context: NSManagedObjectContext) -> User? {
        let predicate = NSPredicate(format: "email_ = %@ AND password_ = %@", email, password)
        let matchingUsers = (try? context.fetch(User.fetchRequest(predicate))) ?? []
        return matchingUsers.first
    }
}

extension User {

    static func create(name: String, email: String, password: String, in context: NSManagedObjectContext) -> User? {
        if User.with(email: email, from: context) != nil {
            return nil
        }
        let newUser = User(context: context)
        newUser.name = name
        newUser.email = email
        newUser.password = password
        return newUser
    }
    
    static func create(from schema: UserSchema, in context: NSManagedObjectContext) -> User {
        if let user = User.with(email: schema.email, from: context) {
            update(user, from: schema)
            return user
        }
        return User(from: schema, in: context)
    }
    
    static func update(_ user: User, from schema: UserSchema) {
        user.name = schema.name
        user.password = schema.password
        user.diets = schema.diets.map({ Diet(rawValue: $0) }).compactMap { $0 }
        user.favorites = schema.favorites.map { Recipe.create(from: $0, in: user.managedObjectContext!) }
        user.collections = schema.collections.map { Collection.create(from: $0, for: user, in: user.managedObjectContext!) }
        try? user.managedObjectContext?.save()
    }
}
