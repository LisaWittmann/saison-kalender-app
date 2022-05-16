//
//  SeasonView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct SeasonView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(entity: Seasonal.entity(), sortDescriptors: [ NSSortDescriptor(key: "name_", ascending: true) ])
    var seasonals: FetchedResults<Seasonal>
    
    var body: some View {
        ScrollView {
            TabView {
                ForEach(currentSeasonals) { seasonal in
                    SeasonItem(seasonal)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: screenHeight)
        }
        .modifier(PageLayout())
    }
    
    private var currentSeasonals: Array<Seasonal> {
        seasonals
            .filter({ $0.seasonal })
            .sorted()
    }
}

struct SeasonItem: View {
    @EnvironmentObject var user: AppUser
    @ObservedObject var seasonal: Seasonal
    
    init(_ seasonal: Seasonal) {
        self.seasonal = seasonal
    }
    
    var body: some View {
        VStack {
            Headline(seasonal.name.syllable(), "Saisonal im \(Season.current.name)")
                .foregroundColor(colorBlack)
                .modifier(SectionLayout())
                .frame(height: headerHeight, alignment: .topLeading)
            
            NavigationLink(destination: detail(for: seasonal)) {
                hightlight()
            }.isDetailLink(false)
           
            Spacer()
        }
    }
    
    @ViewBuilder
    private func hightlight() -> some View {
        ZStack {
            Circle()
                .fill(Color(Season.current.name))
                .frame(width: circleSize, height: circleSize)
            Image(seasonal.name.normalize())
                .resizable()
                .scaledToFill()
                .frame(
                    width: screenWidth,
                    height: imageHeight,
                    alignment: .center
                )
                .clipped()
                .shadow(radius: shadowRadius)
        }
    }
    
    @ViewBuilder
    private func detail(for seasonal: Seasonal) -> some View {
        SeasonalDetailView(seasonal)
            .navigationLink()
    }
    
    let circleSize: CGFloat = contentWidth
    let imageHeight: CGFloat = contentWidth
    let headerHeight: CGFloat = 250
    let buttonSize: CGFloat = 60
    let animationDuration: Double = 1
    let shadowRadius: CGFloat = 40
}

struct SeasonView_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        NavigationView {
            SeasonView()
                .environment(\.managedObjectContext, controller.container.viewContext)
                .environmentObject(AppUser.shared)
                .environmentObject(ViewRouter.shared)
        }
    }
}
