//
//  FontModifier.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct FontTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontExtraBold, size: fontSizeTitle))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FontSubtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontMedium, size: fontSizeSubtitle))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FontH1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontSemiBold, size: fontSizeHeadline1))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(colorBlack)
    }
}

struct FontH2: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontSemiBold, size: fontSizeHeadline2))
            .frame(maxWidth: .infinity, alignment: .leading)
            .foregroundColor(colorGrey)
    }
}

struct FontText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontMedium, size: fontSizeText))
            .foregroundColor(colorBlack)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct FontError: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontMedium, size: fontSizeHeadline2))
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

struct FontLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.custom(fontMedium, size: fontSizeHeadline2))
    }
}

