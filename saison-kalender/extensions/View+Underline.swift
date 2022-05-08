//
//  View+Underline.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 05.05.22.
//

import Foundation
import SwiftUI

extension View {
    
    func underline(color: Color = colorGreen, opacity: Double = 0.5) -> some View {
        self.overlay(
                Rectangle()
                    .frame(height: 2)
                    .padding(.top, 55)
                    .opacity(opacity)
            )
            .foregroundColor(color)
            .paddingVertical(spacingExtraSmall)
    }
}
