//
//  RepresentableData.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

protocol RepresentableData: Hashable, Identifiable, ObservableObject {

    var name: String { get }
    
    static func == (lhs: Self, rhs: Self) -> Bool
}
