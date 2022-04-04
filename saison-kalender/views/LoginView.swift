//
//  LoginView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var user: LoggedInUser
    @State private var loginMode = true
    
    var body: some View {
        if loginMode {
            LoginForm(mode: $loginMode)
        }
        else {
            RegisterForm(mode: $loginMode)
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
            Spacer()
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
            Spacer()
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
            Spacer()
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
            Spacer()
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
            mode.toggle()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        LoginView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(LoggedInUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
