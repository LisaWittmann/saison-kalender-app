//
//  Float+ToString.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import Foundation

extension Float {
    
    func toString() -> String {
        let integer: Int = Int(self)

        if (self - Float(integer)) > 0 {
            return "\(self)"
        }
        return "\(integer)"
    }
}
