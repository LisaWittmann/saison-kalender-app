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
    @State var formModel = UserFormModel()
    @State var errorMessage: String? = nil
    
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
            if let error = errorMessage {
                Text(error).modifier(FontError())
                    
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func loginForm() -> some View {
        VStack(spacing: spacingMedium) {
            InputField(
                "Nutzername",
                text: $formModel.name,
                icon: "person.fill"
            )
            InputField(
                "Passwort",
                text: $formModel.password,
                icon: "lock.fill",
                secure: true
            )
            SubmitButton(
                "Anmelden",
                onSubmit: login,
                disabled: !formModel.isValidForLogin()
            )
            Button("Noch kein Konto?", action: switchMode)
                .frame(width: contentWidth, alignment: .trailing)
                .modifier(TextButtonStyle())
        }
    }
    
    @ViewBuilder
    private func registerForm() -> some View {
        VStack(spacing: spacingMedium) {
            InputField(
                "E-Mail",
                text: $formModel.email,
                icon: "envelope.fill",
                validate: formModel.isValidEmail
            )
            InputField(
                "Nutzername",
                text: $formModel.name,
                icon: "person.fill",
                validate: formModel.isValidName
            )
            InputField(
                "Passwort",
                text: $formModel.password,
                icon: "lock.fill",
                secure: true,
                validate: formModel.isValidPassword
            )
            InputField(
                "Passwort wiederholen",
                text: $formModel.passwordRepeat,
                icon: "lock.fill",
                secure: true,
                validate: formModel.isValidPasswordRepeat
            )
            SubmitButton(
                "Registrieren",
                onSubmit: register,
                disabled: !formModel.isValidForRegister()
            )
            Button("Jetzt anmelden", action: switchMode)
                .frame(width: contentWidth, alignment: .trailing)
                .modifier(TextButtonStyle())
        }
    }
    
    private func switchMode() {
        inLoginMode.toggle()
        formModel = UserFormModel()
        errorMessage = nil
    }
    
    private func login() {
        let user = User.with(
            name: formModel.name,
            password: formModel.password,
            from: viewContext
        )
        self.user.login(user)
        
        if self.user.isPresent {
            errorMessage = nil
        } else {
            errorMessage = "Login fehlgeschlagen"
        }
    }
    
    private func register() {
        let user = User.register(
            name: formModel.name,
            email: formModel.email,
            password: formModel.password,
            in: viewContext
        )
        if user != nil {
            switchMode()
        } else {
            errorMessage = "Registrierung fehlgeschlagen"
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
