//
//  View+UnderlineView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Foundation
import SwiftUI

extension View {
    
    func underlineView(color: Color = colorGreen, opacity: Double = 0.5) -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .padding(.top, 55)
                    .opacity(opacity)
            )
            .foregroundColor(color)
            .padding(.top, spacingExtraSmall)
            .padding(.bottom, spacingExtraSmall)
    }
}
