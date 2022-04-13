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
    
    @State var inLoginMode = true
    @State var loginModel = LoginModel()
    @State var registerModel = RegisterModel()
    
    var body: some View {
        Page {
            Headline(
                inLoginMode ? "Anmelden" : "Registrieren",
                "Dein Bereich"
            )
            Spacer()
            if inLoginMode {
                loginForm()
            }
            else {
                registerForm()
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func loginForm() -> some View {
        VStack(spacing: spacingMedium) {
            InputField($loginModel.name,
                placeholder: "Nutzername",
                icon: "person.fill"
            )
            InputField($loginModel.password,
                placeholder: "Passwort",
                icon: "lock.fill",
                secure: true
            )
            Button("Anmelden", action: login)
                .frame(width: contentWidth)
                .modifier(ButtonStyle())
            Button("Noch kein Konto?", action: { inLoginMode.toggle() })
                .frame(
                    width: contentWidth,
                    alignment: .trailing
                )
                .modifier(TextButtonStyle())
        }
    }
    
    @ViewBuilder
    private func registerForm() -> some View {
        VStack(spacing: spacingMedium) {
            InputField($registerModel.email,
                placeholder: "E-Mail",
                icon: "envelope.fill"
            )
            InputField($registerModel.name,
                placeholder: "Nutzername",
                icon: "person.fill"
            )
            InputField($registerModel.password,
                placeholder: "Passwort",
                icon: "lock.fill"
            )
            InputField($registerModel.passwordRepeat,
                placeholder: "Passwort wiederholen",
                icon: "lock.fill",
                secure: true
            )
            Button("Registrieren", action: register)
                .frame(width: contentWidth)
                .modifier(ButtonStyle())
            Button("Jetzt anmelden", action: { inLoginMode.toggle() })
                .frame(
                    width: contentWidth,
                    alignment: .trailing
                )
                .modifier(TextButtonStyle())
        }
    }
    
    private func login() {
        let user = User.with(
            name: loginModel.name,
            password: loginModel.password,
            from: viewContext
        )
        self.user.login(user)
    }
    
    private func register() {
        let user = User.create(
            name: registerModel.name,
            email: registerModel.email,
            password: registerModel.password,
            in: viewContext
        )
        if user != nil {
            inLoginMode.toggle()
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
