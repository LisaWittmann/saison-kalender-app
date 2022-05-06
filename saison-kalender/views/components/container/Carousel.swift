//
//  Slider.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Carousel<Data, Content> : View where Data : Identifiable, Content: View {
    var spacing: CGFloat
    var data: [Data]
    var content: (Data) -> Content
    
    init(
        _ data: [Data],
        spacing: CGFloat = spacingMedium,
        @ViewBuilder content: @escaping (Data) -> Content
    ) {
        self.spacing = spacing
        self.data = data
        self.content = content
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: spacing) {
                ForEach(data) { data in
                    content(data)
                        .padding(.leading, getPaddingLeft(data))
                        .padding(.trailing, getPaddingRight(data))
                }
            }
        }
        .padding(.top, spacingExtraSmall)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, -spacingLarge)
        .padding(.trailing, -spacingLarge)
    }
    
    private func getPaddingLeft(_ data: Data) -> CGFloat {
        if self.data.first?.id == data.id {
            return spacingLarge
        }
        return 0
    }
    
    private func getPaddingRight(_ data: Data) -> CGFloat{
        if self.data.last?.id == data.id {
            return spacingLarge
        }
        return 0
    }
}
