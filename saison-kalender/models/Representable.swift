//
//  Representable.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.04.22.
//

import Foundation

protocol Representable: Identifiable, Hashable {
    
    var name: String { get }
}
