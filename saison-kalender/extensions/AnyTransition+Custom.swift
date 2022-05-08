//
//  AnyTransition+Custom.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 08.05.22.
//

import Foundation
import SwiftUI

extension Edge {
    
    var opposite: Edge {
        switch self {
        case .top: return .bottom
        case .leading: return .trailing
        case .bottom: return .top
        case .trailing: return .leading
        }
    }
}
extension AnyTransition {
    
    static func customSlide(in edge: Edge) -> AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: edge),
            removal: .move(edge: edge.opposite)
        )
    }
}
