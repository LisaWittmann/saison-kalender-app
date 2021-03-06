//
//  RecipeDetailView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 28.03.22.
//

import SwiftUI
import PartialSheet

struct RecipeDetailView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var user: AppUser
    
    @StateObject var manager = CollectionManager()
    @ObservedObject var recipe: Recipe
    var collection: Collection?

    @State var isPresented = false
    
    init(_ recipe: Recipe, collection: Collection? = nil) {
        self.recipe = recipe
        self.collection = collection
    }
    
    var body: some View {
        DetailPage(
            images: [recipe.name.normalize()],
            title: { Text(recipe.name.syllable()).modifier(FontTitle()) },
            icon: { Icon(icon, onTap: onIconTap, onPress: onIconPressed) }
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
                IngredientList(recipe.ingredients, for: recipe.portions)
            }
            
            if !recipe.preparations.isEmpty {
                body(for: recipe.preparations)
            }
            
            if let seasonals = recipe.seasonalsFor(Season.current), !seasonals.isEmpty {
                body(for: seasonals)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear { manager.set(recipe: recipe, with: collection) }
        .onSwipe(left: { dismiss() })
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
            ContentCard(description: "Kalorien", value: "\(nutrition.calories.toString())")
                .frame(height: 80)
            ContentCard(description: "Eiwei??", value: "\(nutrition.protein.toString())g")
                .frame(height: 80)
            ContentCard(description: "Fett", value: "\(nutrition.fat.toString())g")
                .frame(height: 80)
            ContentCard(description: "Kohlen\u{00AD}hydrate", value: "\(nutrition.carbs.toString())g")
                .frame(height: 80)
        }
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
                    .frame(width: halfContentWidth, height: halfContentWidth)
            }
        }
    }
    
    private var icon: String {
        user.favorites.contains(recipe) ? "heart.fill" : "heart"
    }
    
    private func onIconPressed() {
        guard user.isAuthorized else {
            user.requireAuthorization(for: { self.onIconPressed() })
            return
        }
        manager.open(with: .save)
    }
    
    private func onIconTap() {
        if user.favorites.contains(recipe) {
            if collection != nil {
                manager.open(with: .delete)
                return
            }
            user.remove(recipe: recipe)
        } else {
            user.favor(recipe)
        }
    }
}

struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        let user = AppUser.shared
        let users = try! controller.container.viewContext.fetch(User.fetchRequest())
        
        let recipes = try! controller.container.viewContext.fetch(Recipe.fetchRequest())
        let recipe = recipes.randomElement()!
        
        RecipeDetailView(recipe)
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(ViewRouter.shared)
            .environmentObject(user)
            .onAppear { user.login(users.first) }
    }
}
