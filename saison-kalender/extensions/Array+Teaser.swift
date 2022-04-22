//
//  Array+Teaser.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Foundation

extension Array {
    
    func teaser(_ count: Int) -> Array {
        if self.count > count {
            return Array(self[0...count-1])
        }
        return self
    }
}
