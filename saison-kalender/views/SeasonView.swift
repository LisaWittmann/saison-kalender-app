//
//  SeasonView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct SeasonView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    
    var seasonals: [Seasonal] {
        return Seasonal.current(context: viewContext)
    }
    
    var body: some View {
        ScrollView {
            TabView {
                ForEach(Array(seasonals)) { item in
                    SeasonItem(seasonal: item).environmentObject(user)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .modifier(FullScreenLayout())
        }
        .modifier(PageLayout())
    }
}

struct SeasonItem: View {
    @ObservedObject var seasonal: Seasonal
    @EnvironmentObject var user: LoggedInUser
    @State var showDetail: Bool = false
    
    var body: some View {
        VStack {
            Headline(
                title: seasonal.name,
                subtitle: "Saisonal im \(Season.current.name)",
                color: colorBlack
            )
            ZStack {
                Circle()
                    .fill(colorGreen)
                    .frame(
                        width: circleSize,
                        height: circleSize
                    )
                Image(seasonal.name)
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
            Spacer()
        }
        .ignoresSafeArea()
        .onTapGesture { showDetail.toggle() }
        .fullScreenCover(isPresented: $showDetail, content: {
            SeasonalDetail(
                seasonal: seasonal,
                close: { showDetail.toggle() }
            ).environmentObject(user)
        })
    }
    
    let circleSize: CGFloat = contentWidth
    let imageHeight: CGFloat = contentWidth * 1.5
    let imageOpacity: Double = 0.7
    let buttonSize: CGFloat = 60
    let animationDuration: Double = 1
    let shadowRadius: CGFloat = 40
}

struct SeasonView_Previews: PreviewProvider {
    static var previews: some View {
        SeasonView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
