//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI

struct RecipeDetail: View {
    @EnvironmentObject var seasonCalendar: SeasonCalendar
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
                images: [recipe.slot],
                headline: recipe.name,
                close: close,
                icon: icon,
                onIconTap: onIconTap
            ) {
                Text(recipe.name).modifier(FontH1())
                
                if !recipe.categories.isEmpty {
                    TagList(recipe.categories)
                }
                                
                if let intro = recipe.intro {
                    Text(intro).modifier(FontText())
                }
            
                if let nutrition = recipe.nutrition {
                    body(for: nutrition)
                }
                
                if !recipe.ingredients.isEmpty {
                    body(for: recipe.ingredients)
                }
                
                if !recipe.preparations.isEmpty {
                    body(for: recipe.preparations)
                }
                
                if let seasonals = recipe.seasonalsFor(seasonCalendar.season), !seasonals.isEmpty {
                    body(for: seasonals)
                }
            }
            if manager.isPresented {
                VStack {
                    Spacer()
                    RecipeContextMenu(manager: manager)
                        .zIndex(.infinity)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear { manager.set(recipe: recipe) }
    }
    
    @ViewBuilder
    private func body(for nutrition: Nutrition) -> some View {
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
    
    @ViewBuilder
    private func body(for ingredients: Array<Ingredient>) -> some View {
        Section("Zutaten") {
            ForEach(ingredients) { ingredient in
                detail(for: ingredient)
            }
        }
    }
    
    @ViewBuilder
    private func detail(for ingredient: Ingredient) -> some View {
        HStack(spacing: spacingSmall) {
            Image(ingredient.slot)
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
    private func body(for preparations: Array<Preparation>) -> some View {
        Section("Zubereitung") {
            ForEach(preparations) { preparation in
                detail(for: preparation)
            }
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
    private func body(for seasonals: Array<Seasonal>) -> some View {
        Section("Saisonale Stars") {
            Carousel(seasonals) { seasonal in
                SeasonalTeaser(seasonal)
            }
        }
    }
    
    private var icon: String {
        if !user.isPresent { return "" }
        if user.favorites.contains(recipe) { return "heart.fill" }
        return "heart"
    }
    
    private func onIconTap() {
        if user.favorites.contains(recipe) {
            user.remove(recipe: recipe)
        } else {
            user.favor(recipe: recipe)
            manager.open(with: .save)
        }
    }
}

/*struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let users = try! calendar.context.fetch(User.fetchRequest())
        
        RecipeDetail(calendar.recipes.randomElement()!, close: {})
            .environmentObject(calendar)
            .environmentObject(LoggedInUser(users.first))
    }
}*/
