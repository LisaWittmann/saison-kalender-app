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
                Image(systemName: "arrow.left")
                    .foregroundColor(colorBlack)
                    .font(.custom(fontSemiBold, size: fontSizeHeadline2))
                    .padding(spacingExtraSmall)
            }
                
        }
        .shadow(color: colorGrey, radius: shadowRadius)
        .padding(.leading, spacingSmall)
        .padding([.top, .bottom], shadowRadius)
    }
    
    let shadowRadius: CGFloat = 10
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            BackButton()
        }
    }
}
