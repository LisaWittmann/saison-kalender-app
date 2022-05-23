//
//  RegistrationForm.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import SwiftUI

struct RegistrationForm: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var viewRouter: ViewRouter
    @EnvironmentObject var user: AppUser
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var passwordRepeat = ""
    @State var errorMessage: String? = nil
    
    var toLogin: () -> Void = {}
    
    var body: some View {
        if !user.isAuthorized {
            VStack(spacing: spacingMedium) {
                InputField("E-Mail", text: $email, icon: "envelope.fill", validate: AppUser.isValidEmail)
                InputField("Name", text: $name, icon: "person.fill", validate: AppUser.isValidName)
                InputField("Passwort",text: $password, icon: "lock.fill", secure: true, validate: AppUser.isValidPassword)
                InputField("Passwort wiederholen", text: $passwordRepeat, icon: "lock.fill", secure: true, validate: equalPasswords)
                SubmitButton("Registrieren", onSubmit: register, disabled: !isValid)
                Button("Jetzt anmelden", action: toLogin)
                    .frame(width: contentWidth, alignment: .trailing)
                    .modifier(TextButtonStyle())
                Spacer()
                if let error = errorMessage {
                    Text(error).modifier(FontError())
                }
                Spacer()
            }
        }
        else {
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemWidth)), count: columns), spacing: spacingExtraLarge) {
                ForEach(Diet.allCases, id: \.self) { diet in
                    icon(for: diet)
                }
            }
            Button("Bestätigen", action: user.authorized)
                .frame(width: itemWidth * CGFloat(columns))
                .modifier(ButtonStyle())
                .padding(.top, spacingExtraLarge)
        }
    }
    
    @ViewBuilder
    private func icon(for diet: Diet) -> some View {
        VStack(alignment: .center) {
            Image(diet.name.normalize())
                .resizable()
                .scaledToFit()
            Text(diet.name.normalize())
        }
        .padding(spacingExtraSmall)
        .opacity(user.diets.contains(diet) ? 1 : inactiveOpacity)
        .onTapGesture { user.change(diet: diet) }
    }
    
    private var isValid: Bool {
        AppUser.isValidEmail(email) &&
        AppUser.isValidName(name) &&
        AppUser.isValidPassword(password) &&
        equalPasswords(passwordRepeat)
    }
    
    private func equalPasswords(_ passwordRepeat: String) -> Bool {
        password == passwordRepeat
    }
    
    private func register() {
        user.register(name: name, email: email, password: password, in: viewContext)
        guard user.isAuthorized else {
            errorMessage = "Registrierung fehlgeschlagen"
            return
        }
        errorMessage = nil
    }
    
    let columns = 2
    let itemWidth: CGFloat = 110
    let inactiveOpacity = 0.5
}


struct RegistrationForm_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
       
        RegistrationForm()
            .padding(spacingLarge)
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(AppUser.shared)
            .environmentObject(ViewRouter.shared)
    }
}
