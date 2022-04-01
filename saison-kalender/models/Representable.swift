//
//  Representable.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import Foundation

protocol Representable: Identifiable, ObservableObject {
    
    var name: String { get set }
    
}
