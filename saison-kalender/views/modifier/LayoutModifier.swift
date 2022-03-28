//
//  LayoutModifier.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI



struct FullScreenLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(
                width: UIScreen.screenWidth,
                height: UIScreen.screenHeight,
                alignment: .topLeading
            )
    }
}

struct PageLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .modifier(FullScreenLayout())
            .background(colorBeige)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct SectionLayout: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(
                EdgeInsets(
                    top: spacingExtraLarge,
                    leading: spacingLarge,
                    bottom: spacingLarge,
                    trailing: spacingLarge
                )
            )
    }
}
