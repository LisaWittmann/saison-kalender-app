//
//  Slider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Slider<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacingMedium, content: content)
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
