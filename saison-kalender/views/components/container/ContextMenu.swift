//
//  ContextMenu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.04.22.
//

import SwiftUI

struct ContextMenu<Content: View>: View {
    var content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            VStack(content: content)
        }
        .padding(.top, spacingExtraSmall)
        .padding(.bottom, spacingExtraSmall)
        .frame(width: screenWidth, height: viewHeight, alignment: .topLeading)
        .background(colorBeige)
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        .shadow(radius: cornerRadius)
        
    }
    
    let cornerRadius: CGFloat = 40
    let itemSpacing: CGFloat = 10
    let cellWidth: CGFloat = 100
    let viewHeight: CGFloat = 260
}

struct ContextMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContextMenu {
            ContextNavigation(header: "ContextMenu")
        }
    }
}
