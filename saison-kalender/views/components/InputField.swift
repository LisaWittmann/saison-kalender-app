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
    var icon: String
    var secure: Bool
    
    init(_ input: Binding<String>, placeholder: String, icon: String = "", secure: Bool = false) {
        self._input = input
        self.placeholder = placeholder
        self.icon = icon
        self.secure = secure
    }

    var body: some View {
        HStack(spacing: spacingMedium) {
            if icon != "" {
                Image(systemName: icon)
                    .foregroundColor(colorGreen)
            }
            if secure {
                SecureField(placeholder, text: $input)
                    .modifier(TextFieldStyle())
            }
            else {
                TextField(placeholder, text: $input)
                    .modifier(TextFieldStyle())
            }
        }
        .modifier(InputFieldStyle())
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingMedium) {
            InputField(.constant(""),
                placeholder:  "E-Mail",
                icon: "envelope.fill"
            )
            InputField(.constant("Nutzername124"),
                placeholder: "Nutzername",
                icon: "person.fill"
            )
            InputField(.constant(""),
                placeholder: "Passwort"
            )
        }.padding()
    }
}

