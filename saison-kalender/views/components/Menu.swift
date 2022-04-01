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
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadiusSmall)
                .frame(
                    width: tabSizeWidth,
                    height: tabSizeHeight
                )
                .foregroundColor(colorBeige)
                .shadow(
                    radius: shadowRadius,
                    x: shadowOffsetX,
                    y: shadowOffsetY
                )
            HStack(spacing: getIconSpacing()) {
                ForEach(Route.allCases, id: \.self) { route in
                    Button(action: {
                        viewRouter.currentView = route
                    }, label: {
                        Image(systemName: viewRouter.imageName(route: route))
                            .resizable()
                            .frame(
                                width: tabItemSize,
                                height: tabItemSize,
                                alignment: .center
                            )
                        .foregroundColor(getIconColor(route: route))
                            .animation(.easeInOut)
                    })
                }
            }
        }
    }
    
    let tabSizeWidth: CGFloat = contentWidth
    let tabSizeHeight: CGFloat = 60
    let tabItemSize: CGFloat = 30
    
    let shadowRadius: CGFloat = 15
    let shadowOffsetX: CGFloat = 0
    let shadowOffsetY: CGFloat = 5
    
    let colorIcon = colorGreen
    let colorIconActive = colorCurry
    
    private func getIconSpacing() -> CGFloat {
        return (tabSizeWidth - tabItemSize * CGFloat(Route.allCases.count))
            / CGFloat(Route.allCases.count)
    }
    
    private func getIconColor(route: Route) -> Color {
        if route == viewRouter.currentView {
            return colorIconActive
        }
        return colorIcon
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu().environmentObject(ViewRouter())
    }
}
