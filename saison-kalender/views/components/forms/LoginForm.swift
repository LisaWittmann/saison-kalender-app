//
//  LoginForm.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import SwiftUI

struct LoginForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: AppUser
    
    @State var email = ""
    @State var password = ""
    
    @State var errorMessage: String? = nil
    var toRegistration: () -> Void = {}
    
    var body: some View {
        VStack(spacing: spacingMedium) {
            InputField("E-Mail", text: $email, icon: "envelope.fill", validate: AppUser.isValidEmail)
            InputField("Passwort", text: $password, icon: "lock.fill", secure: true)
            SubmitButton("Anmelden", onSubmit: login, disabled: !isValid)
            Button("Noch kein Konto?", action: toRegistration)
                .frame(width: contentWidth, alignment: .trailing)
                .modifier(TextButtonStyle())
            Spacer()
            if let error = errorMessage {
                Text(error).modifier(FontError())
            }
            Spacer()
        }
    }
    
    private var isValid: Bool {
        AppUser.isValidEmail(email) && password != ""
    }
    
    private func login() {
        user.login(User.with(email: email, password: password, from: viewContext))
        guard user.isAuthorized else {
            errorMessage = "Login fehlgeschlagen"
            return
        }
        errorMessage = nil
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        LoginForm()
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(AppUser.shared)
            .environmentObject(ViewRouter.shared)
    }
}
