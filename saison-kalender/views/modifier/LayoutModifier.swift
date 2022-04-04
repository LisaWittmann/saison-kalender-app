//
//  LayoutModifier.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI


struct PageLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(colorBeige)
            .edgesIgnoringSafeArea(.all)
            .frame(width: screenWidth, alignment: .topLeading)
    }
}

struct SectionLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(
                EdgeInsets(
                    top: spacingExtraLarge,
                    leading: spacingLarge,
                    bottom: spacingExtraLarge,
                    trailing: spacingLarge
                )
            )
    }
}
