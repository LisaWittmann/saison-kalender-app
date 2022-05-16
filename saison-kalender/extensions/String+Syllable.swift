//
//  String+Syllable.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 16.05.22.
//

import Foundation

extension String {
    
    func syllable() -> String {
        return "\u{00AD}" + self + "\u{00AD}"
    }
}
