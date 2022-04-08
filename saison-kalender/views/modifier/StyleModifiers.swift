//
//  StyleModifiers.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct InputFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(spacingSmall)
            .background(colorLightGreen)
            .cornerRadius(cornerRadiusMedium)
            .foregroundColor(colorBlack)
    }
}

struct TextFieldStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .disableAutocorrection(true)
            .autocapitalization(.none)
            .font(.custom(fontMedium,
                size: fontSizeHeadline2
            ))
            .foregroundColor(colorBlack)
    }
}

struct ButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorWhite)
            .padding(.top, spacingSmall)
            .padding(.bottom, spacingSmall)
            .background(colorGreen)
            .cornerRadius(cornerRadiusMedium)
            .font(.custom(fontBold,
                size: fontSizeHeadline2
            ))
    }
}

struct TextButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(colorGreen)
            .padding(.top, spacingExtraSmall)
            .font(.custom(fontBold,
                size: fontSizeHeadline2
            ))
    }
}

struct BlurredImageStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 0.5)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadiusSmall)
                    .fill(colorBlack)
                    .opacity(0.3)
            )
            .cornerRadius(cornerRadiusSmall)
    }
}

