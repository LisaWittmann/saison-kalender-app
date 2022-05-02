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
            .frame(height: UIScreen.main.bounds.height)
        }
        .modifier(PageLayout())
    }
}

struct SeasonItem: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var seasonCalendar: SeasonCalendar
    
    @ObservedObject var seasonal: Seasonal
    @State private var showDetail: Bool = false
    
    var body: some View {
        VStack {
            Headline(
                seasonal.name,
                "Saisonal im \(seasonCalendar.season.name)"
            )
            .modifier(SectionLayout())
            
            NavigationLink(
                destination: detail(for: seasonal),
                isActive: $showDetail
            ) {
                hightlight()
            }
            .isDetailLink(false)
           
            Spacer()
        }
        .onTapGesture { showDetail.toggle() }
    }
    
    @ViewBuilder
    private func hightlight() -> some View {
        ZStack {
            Circle()
                .fill(colorGreen)
                .frame(width: circleSize, height: circleSize)
            Image(seasonal.slug)
                .resizable()
                .scaledToFill()
                .frame(
                    width: screenWidth,
                    height: imageHeight,
                    alignment: .center
                )
                .opacity(imageOpacity)
                .clipped()
                .shadow(radius: shadowRadius)
        }
    }
    
    @ViewBuilder
    private func detail(for seasonal: Seasonal) -> some View {
        SeasonalDetail(seasonal, close: { showDetail.toggle() })
            .navigationBarHidden(true)
    }
    
    let circleSize: CGFloat = contentWidth
    let imageHeight: CGFloat = contentWidth * 1.5
    let imageOpacity: Double = 0.9
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
