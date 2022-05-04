//
//  AppUser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import CoreData

class AppUser: ObservableObject {
    
    @Published var user: User?
    @Published var requiresAuthorization: Bool
    
    var name: String? { user?.name }
    var email: String? { user?.email }
    var isAuthenticated: Bool { user != nil }
    
    init(_ user: User? = nil) {
        self.user = user
        self.requiresAuthorization = false
    }
    
    var favorites: Set<Recipe> {
        get { Set(user?.favorites ?? []) }
        set { user?.favorites = Array(newValue) }
    }
    
    var collections: Set<Collection> {
        get { Set(user?.collections ?? []) }
        set { user?.collections = Array(newValue) }
    }
    
    var diets: Set<Diet> {
        get { Set(user?.diets ?? []) }
        set { user?.diets = Array(newValue) }
    }
}

extension AppUser {
    
    func update(diet: Diet) {
        if diets.contains(diet) {
            diets.remove(diet)
        } else {
            diets.insert(diet)
        }
        save()
    }
    
    func favor(recipe: Recipe) {
        user?.addToFavorites_(recipe)
        save()
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        favor(recipe: recipe)
        collection.addToRecipes_(recipe)
        save()
    }
    
    func add(collection: Collection) {
        user?.addToCollections_(collection)
        save()
    }
        
    func remove(recipe: Recipe, from collection: Collection) {
        if (collection.recipes.contains(recipe)) {
            collection.recipes.remove(recipe)
            // remove empty collections
            if collection.recipes.count < 1 {
                remove(collection: collection)
            }
        }
        save()
    }
        
    func remove(recipe: Recipe) {
        for collection in collections {
            remove(recipe: recipe, from: collection)
        }
        favorites.remove(recipe)
        save()
    }
        
    func remove(collection: Collection) {
        collections.remove(collection)
        save()
    }
    
    func save() {
        try? user?.managedObjectContext?.save()
        objectWillChange.send()
    }
}

extension AppUser {
    
    func getStoredSession(_ context: NSManagedObjectContext) {
        let storedUser = UserDefaults.standard.object(forKey: "user") as? String
        if storedUser != nil {
            user = User.with(email: storedUser!, from: context)
        }
    }
    
    func login(_ user: User?) {
        self.user = user
        if user != nil {
            UserDefaults.standard.set(user?.email, forKey: "user")
            authorizationCompleted()
        }
    }
    
    func logout() {
        user = nil
        UserDefaults.standard.set(nil, forKey: "user")
    }
    
    func register(name: String, email: String, password: String, in context: NSManagedObjectContext) {
        if User.with(email: email, from: context) == nil {
            user = User.create(name: name, email: email, password: password, in: context)
        }
    }
    
    func authorizationCompleted() {
        requiresAuthorization = false
    }
    
    func requireAuthorization() {
        requiresAuthorization = !isAuthenticated
    }
}

extension AppUser {
    
    func checkPassword(_ password: String) -> Bool {
        user?.password == password
    }
    
    func changePassword(_ newPassword: String) {
        user?.password = newPassword
        save()
    }
    
    func change(email: String, name: String) {
        if email != "" {
            user?.email = email
        }
        if name != "" {
            user?.name = name
        }
        save()
    }
}

extension AppUser {
    
    static func isValidName(_ name: String) -> Bool {
        let nameFormat = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameFormat)
        return namePredicate.evaluate(with: name)
    }
    
    static func isValidEmail(_ email: String) -> Bool {
        let name = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let domain = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailFormat = name + "@" + domain + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        let passwordFormat = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[$@$#!%*?&]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordFormat)
        return passwordPredicate.evaluate(with: password)
    }
}
