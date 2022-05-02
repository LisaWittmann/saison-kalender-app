//
//  LoginView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 24.03.22.
//

import SwiftUI

struct LoginForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: AppUser
    
    @State var email = ""
    @State var password = ""
    
    @Binding var errorMessage: String?
    var toRegistration: () -> Void = {}
    
    var body: some View {
        VStack(spacing: spacingMedium) {
            InputField(
                "E-Mail",
                text: $email,
                icon: "envelope.fill"
            )
            InputField(
                "Passwort",
                text: $password,
                icon: "lock.fill",
                secure: true
            )
            SubmitButton(
                "Anmelden",
                onSubmit: login,
                disabled: !isValid
            )
            Button("Noch kein Konto?", action: toRegistration)
                .frame(width: contentWidth, alignment: .trailing)
                .modifier(TextButtonStyle())
        }
    }
    
    private var isValid: Bool {
        AppUser.isValidEmail(email) && password != ""
    }
    
    private func login() {
        user.login(User.with(email: email, password: password, from: viewContext))
        
        if user.isAuthenticated {
            errorMessage = nil
        } else {
            errorMessage = "Login fehlgeschlagen"
        }
    }
}


struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        LoginForm(errorMessage: .constant(nil))
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
