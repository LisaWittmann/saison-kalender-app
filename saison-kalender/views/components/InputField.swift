//
//  InputField.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct InputField: View {
    @Binding var text: String
    var placeholder: String
    var icon: String? = nil
    var secure: Bool = false
    var validate: ((String) -> Bool)?
    
    @State var error = false
    
    init(_ placeholder: String, text: Binding<String>, icon: String? = nil, secure: Bool = false, validate: ((String) -> Bool)? = nil) {
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
        self.secure = secure
        self.validate = validate
    }

    var body: some View {
        HStack(spacing: spacingMedium) {
            if let systemName = icon {
                Image(systemName: systemName)
                    .foregroundColor(colorGreen)
            }
            Group {
                if secure {
                    SecureField(placeholder, text: $text)
                } else {
                    TextField(placeholder, text: $text)
                }
            }
            .foregroundColor(error ? colorRed : colorBlack)
            .modifier(TextFieldStyle())
            .onChange(of: text, perform: { text in onChange(of: text) })
        }
        .modifier(InputFieldStyle())
        .overlay(
            Capsule(style: .continuous)
                .stroke(colorRed, lineWidth: error ? 2 : 0)
        )
    }
    
    private func onChange(of text: String) {
        if let validateFunc = validate  {
            error = !validateFunc(text)
        }
    }
}

struct InputField_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: spacingMedium) {
            InputField("E-Mail", text: .constant(""), icon: "envelope.fill")
            InputField("Nutzername", text: .constant("Nutzername123"), icon: "person.fill")
            InputField("Passwort", text: .constant(""), secure: true)
        }.padding()
    }
}

