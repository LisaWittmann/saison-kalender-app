//
//  InputField.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct InputField: View {
    @Binding var input: String
    var placeholder: String
    var icon: String = ""
    var secure: Bool = false

    var body: some View {
        HStack(spacing: spacingMedium) {
            ZStack {
                if icon != "" {
                    Image(systemName: icon)
                        .foregroundColor(colorGreen)
                }
            }
            ZStack {
                if secure {
                    SecureField(placeholder, text: $input)
                        .modifier(TextFieldStyle())
                } else {
                    TextField(placeholder, text: $input)
                        .modifier(TextFieldStyle())
                }
            }
        }
        .modifier(InputFieldStyle())
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingMedium) {
            InputField(
                input: .constant(""),
                placeholder:  "E-Mail",
                icon: "envelope.fill"
            )
            InputField(
                input:.constant("Nutzername124"),
                placeholder: "Nutzername",
                icon: "person.fill"
            )
            InputField(
                input: .constant(""),
                placeholder: "Passwort"
            )
        }.padding()
    }
}

