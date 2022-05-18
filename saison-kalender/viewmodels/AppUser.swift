//
//  AppUser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import CoreData

class AppUser: ObservableObject {
    
    static let shared = AppUser()
    
    @Published private(set) var user: User?
    @Published var authRequired: Bool
    
    private var authCallback: () -> Void = {}
    
    var name: String? { user?.name }
    var email: String? { user?.email }
    var isAuthorized: Bool { user != nil }
    
    private init(_ user: User? = nil) {
        self.user = user
        self.authRequired = false
    }
    
    var favorites: Array<Recipe> {
        get { user?.favorites ?? [] }
        set { user?.favorites = newValue }
    }
    
    var collections: Array<Collection> {
        get { user?.collections ?? [] }
        set { user?.collections = newValue }
    }
    
    var diets: Array<Diet> {
        get { user?.diets ?? [] }
        set { user?.diets = newValue }
    }
}

extension AppUser {
    
    func requireAuthorization(for function: (() -> Void)? = nil) {
        if let callback = function {
            authCallback = callback
        }
        authRequired = true
    }
    
    func authorized() {
        authRequired = false
        authCallback()
        authCallback = {}
    }
    
    func dismissAuthorization() {
        authRequired = false
        authCallback = {}
    }
}

extension AppUser {
    
    func favor(recipe: Recipe) {
        guard isAuthorized else {
            requireAuthorization(for: { self.favor(recipe: recipe) })
            return
        }
        user?.addToFavorites_(recipe)
        save()
    }
    
    func add(recipe: Recipe, to collection: Collection) {
        guard isAuthorized else {
            requireAuthorization(for: { self.add(recipe: recipe, to: collection) })
            return
        }
        favor(recipe: recipe)
        collection.addToRecipes_(recipe)
        save()
    }
        
    func remove(recipe: Recipe, from collection: Collection) {
        guard isAuthorized else {
            requireAuthorization(for: { self.remove(recipe: recipe, from: collection) })
            return
        }
        if (collection.recipes.contains(recipe)) {
            collection.recipes = collection.recipes.filter { $0 != recipe }
            
            // remove empty collections
            if collection.recipes.count < 1 {
                remove(collection: collection)
            }
        }
        save()
    }
        
    func remove(recipe: Recipe) {
        guard isAuthorized else {
            requireAuthorization(for: { self.remove(recipe: recipe) })
            return
        }
        for collection in collections {
            remove(recipe: recipe, from: collection)
        }
        favorites = favorites.filter { $0 != recipe }
        save()
    }
    
    func save() {
        try? user?.managedObjectContext?.save()
        objectWillChange.send()
    }
}

extension AppUser {
    
    func add(collection: Collection) {
        guard isAuthorized else {
            requireAuthorization(for: { self.add(collection: collection) })
            return
        }
        user?.addToCollections_(collection)
        save()
    }
    
    func remove(collection: Collection) {
        guard isAuthorized else {
            requireAuthorization(for: { self.remove(collection: collection) })
            return
        }
        collections = collections.filter { $0 != collection }
        save()
    }

    func rename(_ collection: Collection, to name: String) {
        collection.name = name
        save()
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
            authorized()
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
}

extension AppUser {
    
    func checkPassword(_ password: String) -> Bool {
        user?.password == password
    }
    
    func changePassword(_ newPassword: String) {
        guard isAuthorized else {
            requireAuthorization(for: { self.changePassword(newPassword) })
            return
        }
        user?.password = newPassword
        save()
    }
    
    func change(email: String, name: String) {
        guard isAuthorized else {
            requireAuthorization(for: { self.change(email: email, name: name) })
            return
        }
        if email != "" { user?.email = email }
        if name != "" { user?.name = name }
        save()
    }
    
    func change(diet: Diet) {
        guard isAuthorized else {
            requireAuthorization(for: { self.change(diet: diet) })
            return
        }
        if diets.contains(diet) {
            diets = diets.filter { $0 != diet }
        } else {
            diets.append(diet)
        }
        save()
    }
    
    func delete(from context: NSManagedObjectContext) {
        guard isAuthorized else {
            requireAuthorization(for: { self.delete(from: context) })
            return
        }
        try? User.delete(with: email!, from: context)
        logout()
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
