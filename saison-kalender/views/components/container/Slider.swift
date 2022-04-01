//
//  Slider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Slider<Content: View>: View {
    var spacing: CGFloat
    var content: () -> Content
    
    init(spacing: CGFloat = spacingMedium, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing, content: content)
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
