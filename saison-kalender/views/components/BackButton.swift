//
//  BackButton.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 08.05.22.
//

import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: { dismiss() }) {
            ZStack {
                Circle().fill(colorBeige)
                    .shadow(color: colorGrey, radius: shadowRadius)
                Image(systemName: "arrow.left")
                    .foregroundColor(colorBlack)
                    .font(.custom(fontSemiBold, size: fontSizeHeadline2))
                    .padding(spacingExtraSmall)
            }
        }
        .padding([.top, .bottom], shadowRadius * 2)
        .padding(.leading, spacingSmall)
    }
    
    let shadowRadius: CGFloat = 1
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            BackButton()
        }
    }
}
