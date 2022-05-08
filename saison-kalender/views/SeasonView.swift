//
//  SeasonView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct SeasonView: View {
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    var body: some View {
        ScrollView {
            TabView {
                ForEach(Array(seasonCalendar.seasonals)) { item in
                    SeasonItem(seasonal: item)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: screenHeight)
        }
        .modifier(PageLayout())
    }
}

struct SeasonItem: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var seasonal: Seasonal
    
    var body: some View {
        VStack {
            Headline(seasonal.name, "Saisonal im \(seasonCalendar.season.name)")
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
                .fill(seasonCalendar.color)
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
            .navigationBarHidden(true)
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
        let calendar = SeasonCalendar.preview
        
        SeasonView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
