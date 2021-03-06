//
//  Page.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct Page<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: spacingLarge, content: content)
                .modifier(ContentLayout())
        }.modifier(PageLayout())
    }
}

struct Page_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            Text("Test")
        }
    }
}
