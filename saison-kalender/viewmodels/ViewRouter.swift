//
//  ViewRouter.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published var currentView: Route = Route.home
    
    func imageName(route: Route) -> String {
        switch route {
        case .home:
            return "house.fill"
        case .season:
            return "leaf.fill"
        case .recipes:
            return "book.closed.fill"
        case .account:
            return "person.fill"
        }
    }
}

enum Route: CaseIterable {
    case home, recipes, season, account
}
