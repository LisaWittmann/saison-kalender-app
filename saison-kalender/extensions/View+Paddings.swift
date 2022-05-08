//
//  View+Paddings.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 07.05.22.
//

import Foundation
import SwiftUI

extension View {
    
    func paddingHorizontal(_ padding: CGFloat) -> some View {
        self
            .padding(.leading, padding)
            .padding(.trailing, padding)
    }
    
    func paddingVertical(_ padding: CGFloat) -> some View {
        self
            .padding(.top, padding)
            .padding(.bottom, padding)
    }
}
