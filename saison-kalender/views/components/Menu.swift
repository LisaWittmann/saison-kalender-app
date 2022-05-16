//
//  Menu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct Menu: View {
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadiusSmall)
                    .frame(width: tabSizeWidth, height: tabSizeHeight)
                    .foregroundColor(colorBeige)
                    .shadow(
                        radius: shadowRadius,
                        x: shadowOffsetX,
                        y: shadowOffsetY
                    )
                HStack(spacing: iconSpacing) {
                    ForEach(Route.allCases, id: \.self) { route in
                        menuItem(for: route)
                    }
                }
            }
        }.padding(.bottom, spacingLarge)
    }
    
    @ViewBuilder
    private func menuItem(for route: Route) -> some View {
        Icon(viewRouter.imageName(route: route), onTap: { viewRouter.navigate(to: route) })
            .foregroundColor(iconColor(route))
            .frame(width: tabItemSize, height: tabItemSize)
    }
    
    private var iconSpacing: CGFloat {
        return (tabSizeWidth - tabItemSize * CGFloat(Route.allCases.count))
            / CGFloat(Route.allCases.count)
    }
    
    private func iconColor(_ route: Route) -> Color {
        if route == viewRouter.currentView {
            return colorIconActive
        }
        return colorIcon
    }
    
    let tabSizeWidth: CGFloat = contentWidth
    let tabSizeHeight: CGFloat = 60
    let tabItemSize: CGFloat = 30
    
    let shadowRadius: CGFloat = 15
    let shadowOffsetX: CGFloat = 0
    let shadowOffsetY: CGFloat = 5
    
    let colorIcon = colorGreen
    let colorIconActive = colorCurry
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environmentObject(ViewRouter.shared)
    }
}
