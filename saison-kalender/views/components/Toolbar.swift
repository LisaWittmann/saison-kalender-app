//
//  Toolbar.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct Toolbar: View {
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
                    width: UIScreen.screenWidth,
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
                    width: UIScreen.screenWidth,
                    alignment: .trailing
                )
        }
        .frame(width: UIScreen.screenWidth)
        .underlineView()
    }
}

struct Toolbar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingLarge) {
            Toolbar(
                iconLeft: "chevron.left",
                iconRight: "chevron.right",
                header: "Navigation Toolbar"
            )
            Toolbar(
                iconRight: "xmark",
                header: "Overlay Toolbar"
            )
        }
    }
}
