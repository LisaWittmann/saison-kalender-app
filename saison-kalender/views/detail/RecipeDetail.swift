//
//  RecipeDetail.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI
import PartialSheet

struct RecipeDetail: View {
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    @EnvironmentObject var user: AppUser
    
    @StateObject var manager = CollectionManager()
    @ObservedObject var recipe: Recipe
    var collection: Collection?
    var close: () -> ()
    
    @State var isPresented = false
    
    init(_ recipe: Recipe, collection: Collection? = nil, close: @escaping () -> ()) {
        self.recipe = recipe
        self.collection = collection
        self.close = close
    }
    
    var body: some View {
        ZStack {
            DetailPage(
                images: [recipe.slug],
                headline: recipe.name,
                close: close,
                icon: icon,
                onIconTap: onIconTap,
                onIconPressed: onIconPressed
            ) {
                Text(recipe.name).modifier(FontH1())
                
                if !recipe.categories.isEmpty {
                    TagList(recipe.categories)
                }
                                
                if let intro = recipe.intro {
                    Text(intro).modifier(FontParagraph())
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
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear { manager.set(recipe: recipe, with: collection) }
        .partialSheet(
            isPresented: $manager.isPresented,
            type: .dynamic,
            iPhoneStyle: .init(
                background: .solid(colorBeige),
                handleBarStyle: .none,
                cover: .disabled,
                cornerRadius: cornerRadiusMedium
            )) { RecipeContextMenu(manager: manager) }
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
            Image(ingredient.slug)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 30)
            Text(ingredient.name)
                .font(.custom(fontSemiBold, size: fontSizeLabel))
                .foregroundColor(colorBlack)
            Spacer()
            Text("\(ingredient.quantity.description) \(ingredient.unit ?? "")")
                .modifier(FontText())
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
            Text(preparation.text).modifier(FontParagraph())
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
        if !user.isAuthenticated { return "" }
        if user.favorites.contains(recipe) { return "heart.fill" }
        return "heart"
    }
    
    private func onIconTap() {
        if user.favorites.contains(recipe) {
            if collection != nil {
                manager.open(with: .delete)
            } else {
                user.remove(recipe: recipe)
            }
        } else {
            user.favor(recipe: recipe)
        }
    }
    
    private func onIconPressed() {
        manager.open(with: .save)
    }
}

/*struct RecipeDetail_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let recipe = calendar.recipes.randomElement()
        
        RecipeDetail(recipe!, close: {})
            .attachPartialSheetToRoot()
            .environmentObject(LoggedInUser())
            .environmentObject(calendar)
    }
}*/
