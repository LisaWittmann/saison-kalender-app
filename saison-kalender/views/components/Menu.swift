//
//  Menu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct Menu: View {
    @ObservedObject var viewRouter: ViewRouter
    
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
            HStack(
                spacing: getIconSpacing()
            ) {
                ForEach(0..<Route.allCases.count, id: \.self) { i in
                    Button(action: {
                        viewRouter.currentView = Route.allCases[i]
                    }, label: {
                        Image(
                            systemName: viewRouter.imageName(route: Route.allCases[i])
                        )
                            .resizable()
                            .frame(
                                width: tabItemSize,
                                height: tabItemSize,
                                alignment: .center
                            )
                        .foregroundColor(getIconColor(route: Route.allCases[i]))
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
        Menu(viewRouter: ViewRouter() )
    }
}
