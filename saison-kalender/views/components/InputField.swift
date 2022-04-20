//
//  InputField.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct InputField<Content: View>: View {
    var icon: String? = nil
    var error: Bool = false
    var content: () -> Content

    var body: some View {
        HStack(spacing: spacingMedium) {
            if let systemName = icon {
                Image(systemName: systemName)
                    .foregroundColor(colorGreen)
            }
            content().modifier(TextFieldStyle())
        }
        .modifier(InputFieldStyle())
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingMedium) {
            InputField(icon: "envelope.fill") {
                TextField("E-Mail", text: .constant(""))
            }
            InputField(icon: "person.fill") {
                TextField("Nutzername", text: .constant("Nutzername1234"))
            }
            InputField {
                SecureField("Passwort", text: .constant(""))
            }
        }.padding()
    }
}

