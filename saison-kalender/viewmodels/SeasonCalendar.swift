//
//  SeasonCalendar.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 03.04.22.
//

import Foundation
import CoreData
import SwiftUI

class SeasonCalendar: ObservableObject {
    
    static let shared = SeasonCalendar(controller: PersistenceController.shared)
    static let preview = SeasonCalendar(controller: PersistenceController.preview)
    
    @Published private(set) var season: Season
    @Published private(set) var recipes: [Recipe]
    @Published private(set) var seasonals: [Seasonal]
    
    private let persistenceController: PersistenceController
    
    var context: NSManagedObjectContext { persistenceController.container.viewContext }
    var color: Color { Color(season.name) }
    
    private init(controller: PersistenceController) {
        persistenceController = controller
        
        season = SeasonCalendar.getSeason()
        
        recipes = SeasonCalendar.getRecipes(
            for: SeasonCalendar.getSeason(),
            from: controller.container.viewContext
        )
        seasonals = SeasonCalendar.getSeasonals(
            for: SeasonCalendar.getSeason(),
            from: controller.container.viewContext
        )
    }
    
    private static func getSeason() -> Season {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentSeason = Season.allCases.filter { $0.month == currentMonth }.first!
        return currentSeason
    }
    
    private static func getRecipes(for season: Season, from context: NSManagedObjectContext) -> [Recipe] {
        let recipes: [Recipe] = (try? context.fetch(Recipe.fetchRequest())) ?? []
        return recipes.filter { $0.seasons.contains(season) }.sorted()
    }
    
    private static func getSeasonals(for season: Season, from context: NSManagedObjectContext) -> [Seasonal] {
        let seasonals: [Seasonal] = (try? context.fetch(Seasonal.fetchRequest())) ?? []
        return seasonals.filter { $0.seasons.contains(season) }.sorted()
    }
}

extension SeasonCalendar {
    
    func filterRecipes(by category: RecipeCategory? = nil, for diets: Set<Diet> = Set()) -> [Recipe] {
        let dietRecipes = recipes.filter{ diets.allSatisfy($0.diets.contains) }
        if let filter = category {
            return dietRecipes.filter { $0.categories.contains(filter) }
        }
        return dietRecipes
    }
    
    var popularRecipes: [Recipe] {
        recipes.sorted { (r1, r2) -> Bool in
            r1.favors > r2.favors
        }.filter { $0.favors > 0 }
    }
}
