//
//  ViewRouter.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published private(set) var currentView: Route = Route.home
    @Published private(set) var lastView: Route = Route.home
    
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
    
    func navigate(to route: Route) {
        lastView = currentView
        currentView = route
    }
    
    func back() {
        currentView = lastView
    }
}

enum Route: CaseIterable {
    case home, season, recipes, account
    
    var index: Int {
        Route.allCases.firstIndex(of: self)!
    }
}
