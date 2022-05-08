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
            Image(systemName: "arrow.left")
                .foregroundColor(colorWhite)
                .modifier(FontH1())
        }
        .shadow(color: colorBlack, radius: 20, x: 1, y: 1)
        .padding(.leading, spacingMedium)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        Page {
            BackButton()
        }
    }
}
