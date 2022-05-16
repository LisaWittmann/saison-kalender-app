//
//  Season.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import UIKit

public enum Season: String, CaseIterable {
    
    case January = "Januar", February = "Februar", March = "März", April = "April", May = "Mai", June = "Juni", July = "Juli", August = "August", September = "September", October = "Oktober", November = "November", December = "Dezember"
}

extension Season: Representable {
    
    public var id: Int { month }
    
    var month: Int { Season.allCases.firstIndex(of: self)! + 1 }
    
    var name: String { rawValue }
}

extension Season {
    
    static var current: Season {
        let currentMonth = Calendar.current.component(.month, from: Date())
        return Season.allCases.filter { $0.month == currentMonth }.first!
    }
}
