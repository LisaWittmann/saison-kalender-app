//
//  Month.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import Foundation

enum Month: String, CaseIterable {
    case Januar,
         Februar,
         März,
         April,
         Mai,
         Juni,
         Juli,
         August,
         September,
         November,
         Dezember
    
    func getValue() -> Int {
        return Month.allCases.firstIndex(of: self)! + 1
    }
}
