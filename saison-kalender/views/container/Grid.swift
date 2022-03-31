//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Grid<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        LazyVGrid(columns: gridLayout, alignment: .center, spacing: spacingSmall, content: content)
    }
    
    let gridLayout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
}
