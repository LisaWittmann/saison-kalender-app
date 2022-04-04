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
            .frame(width: screenWidth, alignment: .topLeading)
            .background(colorBeige)
            .edgesIgnoringSafeArea(.all)
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

struct ContentLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(
                EdgeInsets(
                    top: spacingExtraLarge,
                    leading: spacingLarge,
                    bottom: spacingExtraLarge + 60,
                    trailing: spacingLarge
                )
            )
    }
}
