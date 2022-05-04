//
//  Section.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 30.03.22.
//

import SwiftUI

struct Section<Content: View>: View {
    var title: String
    var content: () -> Content
    
    init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    
    var body: some View {
        VStack(spacing: spacingSmall) {
            Text(title).modifier(FontH2())
            VStack(spacing: spacingExtraSmall, content: content)
        }
    }
}

struct Section_Previews: PreviewProvider {
    static var previews: some View {
        Section("Lorem Ipsum") {
            Text("Lorem Ipsum").modifier(FontParagraph())
        }
    }
}
