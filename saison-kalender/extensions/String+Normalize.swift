//
//  String+Normalize.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import Foundation

extension String {
    func normalize() -> String {
        return self.replacingOccurrences(of: "ö", with: "oe")
            .replacingOccurrences(of: "ä", with: "ae")
            .replacingOccurrences(of: "ü", with: "ue")
            .replacingOccurrences(of: "ß", with: "ss")
            .replacingOccurrences(of: " ", with: "-")
            .lowercased()
    }
}
