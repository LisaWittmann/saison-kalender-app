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
            Image(systemName: iconLeft)
                .modifier(FontLabel())
                .onTapGesture { functionLeft() }
                .padding(.leading, spacingSmall)
                .foregroundColor(colorBlack)
                .frame(
                    width: screenWidth,
                    alignment: .leading
                )
            Text(header)
                .modifier(FontLabel())
                .foregroundColor(colorBlack)
            Image(systemName: iconRight)
                .modifier(FontLabel())
                .onTapGesture { functionRight() }
                .padding(.trailing, spacingSmall)
                .foregroundColor(colorBlack)
                .frame(
                    width: screenWidth,
                    alignment: .trailing
                )
        }
        .frame(width: screenWidth)
        .underlineView()
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
