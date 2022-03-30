//
//  Season.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.03.22.
//

import UIKit

public enum Season: String, CaseIterable {
    case Januar, Feburar, März, April, Mai, Juni, Juli, August, September, Oktober, November, Dezember
    
    var month: Int {
        return Season.allCases.firstIndex(of: self)! + 1
    }
    
    var name: String {
        return self.rawValue
    }
    
    static var current: Season {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentSeason = Season.allCases.filter({ $0.month == currentMonth }).first!
        return currentSeason
    }
}
