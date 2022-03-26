//
//  ViewDecorator.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

extension View {
    func underlineView() -> some View {
        self
            .overlay(
                Rectangle()
                    .frame(height: 2)
                    .padding(.top, 55)
                    .opacity(0.2)
            )
            .foregroundColor(colorGreen)
            .padding(spacingExtraSmall)
    }
}
