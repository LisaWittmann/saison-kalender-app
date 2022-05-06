//
//  ContextNavigation.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct ContextNavigation: View {
    var iconLeft: String = ""
    var iconRight: String = ""
    
    var functionLeft: () -> () = {}
    var functionRight: () -> () = {}
    
    var header: String
    
    var body: some View {
        ZStack {
            icon(iconLeft, alignment: .leading, edge: .leading)
                .onTapGesture { functionLeft() }
            Text(header)
                .modifier(FontLabel())
                .foregroundColor(colorBlack)
            icon(iconRight, alignment: .trailing, edge: .trailing)
                .modifier(FontLabel())
                .onTapGesture { functionRight() }
        }
        .frame(width: screenWidth)
        .underline()
    }
    
    @ViewBuilder
    private func icon(_ name: String, alignment: Alignment, edge: Edge.Set) -> some View {
        Image(systemName: name)
            .modifier(FontLabel())
            .padding(edge, spacingSmall)
            .foregroundColor(colorBlack)
            .frame(width: screenWidth, alignment: alignment)
    }
}

struct ContextNavigation_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingLarge) {
            ContextNavigation(
                iconLeft: "chevron.left",
                iconRight: "chevron.right",
                header: "Context Navigation"
            )
            ContextNavigation(
                iconRight: "xmark",
                header: "Context Navigation"
            )
        }
    }
}
