//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct RecipeDetail: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: LoggedInUser
    
    @StateObject var manager = CollectionManager()
    @ObservedObject var recipe: Recipe
    var close: () -> ()
    
    init(_ recipe: Recipe, close: @escaping () -> ()) {
        self.recipe = recipe
        self.close = close
    }
    
    var body: some View {
        ZStack {
            SplitScreen(
                images: [recipe.name],
                headline: recipe.name,
                close: close,
                icon: icon,
                onIconTap: onIconTap
            ) {
                Text(recipe.name).modifier(FontH1())
                
                if !recipe.categories.isEmpty {
                    TagList(Array(recipe.categories))
                }
                                
                if recipe.intro != nil {
                    Text(recipe.intro!).modifier(FontText())
                }
                
                if recipe.nutrition != nil {
                    detail(for: recipe.nutrition!)
                }
                
                if !recipe.ingredients.isEmpty {
                    Section("Zutaten") {
                        ForEach(Array(recipe.ingredients)) { ingredient in
                            detail(for: ingredient)
                        }
                    }
                }
                
                if !recipe.preparations.isEmpty {
                    Section("Zubereitung") {
                        ForEach(Array(recipe.preparations)) { preparation in
                            detail(for: preparation)
                        }
                    }
                }
                
                if !recipe.seasonals.isEmpty {
                    Section("Saisonale Stars") {
                        Carousel {
                            ForEach(Array(recipe.seasonalsFor(season: Season.current))) { seasonal in
                                SeasonalTeaser(seasonal)
                            }
                        }
                    }
                }
            }
            
            VStack {
                Spacer()
                SaveRecipeContextMenu(manager: manager, recipe: recipe)
            }
            .edgesIgnoringSafeArea(.all)
            .opacity(panelOpacity)
        }
    }
    
    @ViewBuilder
    private func detail(for preparation: Preparation) -> some View {
        VStack(spacing: 5) {
            if preparation.title != nil {
                Text(preparation.title!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorBlack)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            Text(preparation.text).modifier(FontText())
            if preparation.info != nil {
                Text(preparation.info!)
                    .font(.custom(fontBold, size: fontSizeText))
                    .foregroundColor(colorCurry)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @ViewBuilder          
    private func detail(for ingredient: Ingredient) -> some View {
        HStack(spacing: spacingSmall) {
            Image(ingredient.name)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 30)
            Text(ingredient.name)
                .font(.custom(fontSemiBold, size: fontSizeLabel))
                .foregroundColor(colorBlack)
            Spacer()
            Text("\(ingredient.quantity.description) \(ingredient.unit ?? "")")
                .font(.custom(fontMedium, size: fontSizeText))
                .foregroundColor(colorBlack)
        }.underlineView(opacity: 0.8)
    }
    
    @ViewBuilder
    private func detail(for nutrition: Nutrition) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4)) {
            ContentPill(
                description: "Kalorien",
                value: "\(nutrition.calories.description)"
            )
            ContentPill(
                description: "Eiweiß",
                value: "\(nutrition.protein.description) g"
            )
            ContentPill(
                description: "Fett",
                value: "\(nutrition.fat.description) g"
            )
            ContentPill(
                description: "Kohlenhydrate",
                value: "\(nutrition.carbs.description) g"
            )
        }
    }
    
    private var panelOpacity: CGFloat {
        manager.isPresented ? 1 : 0
    }
    
    private var icon: String {
        if !user.isPresent {
            return ""
        }
        if user.favorites.contains(recipe) {
            return "heart.fill"
        }
        return "heart"
    }
    
    private func onIconTap() {
        if user.favorites.contains(recipe) {
            user.remove(recipe: recipe)
        } else {
            user.favor(recipe: recipe)
            manager.isPresented.toggle()
        }
    }
}

struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users = try! calendar.context.fetch(User.fetchRequest())
        
        RecipeDetail(calendar.recipes.randomElement()!, close: {})
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
