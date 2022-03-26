//
//  LoginView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct LoginView: View {
    @State var loginMode = true
    
    var body: some View {
        ZStack {
            if loginMode {
                LoginForm(switchMode: displayRegisterForm)
            } else {
                RegisterForm(switchMode: displayLoginForm)
            }
        }
        .modifier(FullScreenLayout())
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
    
    func displayRegisterForm() {
        loginMode = false
    }
    
    func displayLoginForm() {
        loginMode = true
    }
}

struct LoginForm: View {
    @State private var name = ""
    @State private var password = ""
    
    var switchMode: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "Anmelden",
                    subtitle: "Dein Bereich",
                    color: colorBlack
                )
                VStack(spacing: spacingMedium) {
                    InputField(
                        input: $name,
                        placeholder: "Nutzername",
                        icon: "person.fill",
                        secure: false
                    )
                    InputField(
                        input: $password,
                        placeholder: "Passwort",
                        icon: "lock.fill",
                        secure: true
                    )
                    Button("Anmelden", action: login)
                        .frame(width: contentWidth)
                        .modifier(ButtonStyle())
                    Button("Noch kein Konto?", action: switchMode)
                        .frame(
                            width: contentWidth,
                            alignment: .trailing
                        )
                        .modifier(TextButtonStyle())
                }
                .padding(spacingLarge)
            }
        }
        .modifier(PageLayout())
    }
    
    func login() {
        
    }
}

struct RegisterForm: View {
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var passwordRepeat = ""
    
    var switchMode: () -> ()
    
    var body: some View {
        ScrollView {
            VStack {
                Headline(
                    title: "Registrieren",
                    subtitle: "Dein Bereich",
                    color: colorBlack
                )
                VStack(spacing: spacingMedium) {
                    InputField(
                        input: $email,
                        placeholder: "E-Mail",
                        icon: "envelope.fill",
                        secure: false
                    )
                    InputField(
                        input: $name,
                        placeholder: "Nutzername",
                        icon: "person.fill",
                        secure: false
                    )
                    InputField(
                        input: $password,
                        placeholder: "Passwort",
                        icon: "lock.fill",
                        secure: true
                    )
                    InputField(
                        input: $passwordRepeat,
                        placeholder: "Passwort wiederholen",
                        icon: "lock.fill",
                        secure: true
                    )
                    Button("Registrieren", action: register)
                        .frame(width: contentWidth)
                        .modifier(ButtonStyle())
                    Button("Du hast bereits ein Konto?", action: switchMode)
                        .frame(
                            width: contentWidth,
                            alignment: .trailing
                        )
                        .modifier(TextButtonStyle())
                }
                .padding(spacingLarge)
            }
        }
        .modifier(PageLayout())
    }
    
    func register() {
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
