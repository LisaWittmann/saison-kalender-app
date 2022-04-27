//
//  SubmitButton.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 27.04.22.
//

import SwiftUI

struct SubmitButton: View {
    var label: String
    var disabled: Bool
    var onSubmit: () -> Void
    
    init(_ label: String, onSubmit: @escaping () -> Void, disabled: Bool) {
        self.label = label
        self.disabled = disabled
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        Button(label, action: onSubmit)
            .frame(width: contentWidth)
            .modifier(ButtonStyle())
            .disabled(disabled)
            .opacity(disabled ? 0.75 : 1)
    }
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SubmitButton("Anmelden", onSubmit: {}, disabled: true)
            SubmitButton("Registrieren", onSubmit: {}, disabled: false)
        }
    }
}
