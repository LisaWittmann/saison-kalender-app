//
//  LoginView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @State private var loginMode = true
    
    var body: some View {
        if loginMode {
            LoginForm(mode: $loginMode)
            .environment(\.managedObjectContext, viewContext)
            .environmentObject(user)
        }
        else {
            RegisterForm(mode: $loginMode)
                .environment(\.managedObjectContext, viewContext)
        }
    }
}

struct LoginForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: LoggedInUser
    @Binding var mode: Bool

    @State private var name = ""
    @State private var password = ""
    
    var body: some View {
        Page {
            Headline("Anmelden", "Dein Bereich")
            
            VStack(spacing: spacingMedium) {
                InputField($name,
                    placeholder: "Nutzername",
                    icon: "person.fill"
                )
                InputField($password,
                    placeholder: "Passwort",
                    icon: "lock.fill",
                    secure: true
                )
                Button("Anmelden", action: login)
                    .frame(width: contentWidth)
                    .modifier(ButtonStyle())
                Button("Noch kein Konto?", action: { mode.toggle() })
                    .frame(
                        width: contentWidth,
                        alignment: .trailing
                    )
                    .modifier(TextButtonStyle())
            }
        }
    }
    
    func login() {
        user.login(User.with(name: name, password: password, from: viewContext))
    }
}

struct RegisterForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @Binding var mode: Bool
    
    @State private var registerName = ""
    @State private var registerEmail = ""
    @State private var registerPassword = ""
    @State private var registerPasswordRepeat = ""
    
    var body: some View {
        Page {
            Headline("Registrieren", "Dein Bereich")
            
            VStack(spacing: spacingMedium) {
                InputField($registerEmail,
                    placeholder: "E-Mail",
                    icon: "envelope.fill"
                )
                InputField($registerName,
                    placeholder: "Nutzername",
                    icon: "person.fill"
                )
                InputField($registerPassword,
                    placeholder: "Passwort",
                    icon: "lock.fill"
                )
                InputField($registerPasswordRepeat,
                    placeholder: "Passwort wiederholen",
                    icon: "lock.fill",
                    secure: true
                )
                Button("Registrieren", action: register)
                    .frame(width: contentWidth)
                    .modifier(ButtonStyle())
                Button("Jetzt anmelden", action: { mode.toggle() })
                    .frame(
                        width: contentWidth,
                        alignment: .trailing
                    )
                    .modifier(TextButtonStyle())
            }
        }
    }

    func register() {
        let user = User.create(
            name: registerName,
            email: registerEmail,
            password: registerPassword,
            in: viewContext
        )
        if user != nil {
            clear()
            mode.toggle()
        }
    }
    
    func clear() {
        registerName = ""
        registerEmail = ""
        registerPassword = ""
        registerPasswordRepeat = ""
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LoggedInUser())
    }
}
