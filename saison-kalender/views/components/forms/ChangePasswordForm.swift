//
//  ChangePasswordForm.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import SwiftUI

struct ChangePasswordForm: View {
    @EnvironmentObject var user: AppUser
    
    @State var password = ""
    @State var newPassword = ""
    @State var newPasswordRepeat = ""
    
    var body: some View {
        VStack(spacing: spacingSmall) {
            InputField("Altes Passwort", text: $password, icon: "lock.fill", secure: true)
            InputField("Neues Passwort", text: $newPassword, icon: "lock.fill", secure: true, validate: validPassword)
            InputField("Passwort wiederholen", text: $newPasswordRepeat, icon: "lock.fill", secure: true, validate: { pw in newPassword == pw })
            SubmitButton("Passwort aktualisieren", onSubmit: changePassword, disabled: !validPasswordChange)
        }
    }
    
    private var validPasswordChange: Bool {
        AppUser.isValidPassword(newPassword) &&
        user.checkPassword(password) &&
        newPassword == newPasswordRepeat
    }
    
    private func validPassword(_ password: String) -> Bool {
        password == "" || AppUser.isValidPassword(password)
    }
    
    private func validPasswordRepeat(_ passwordRepeat: String) -> Bool {
        password == passwordRepeat
    }
    
    private func changePassword() {
        user.changePassword(newPassword)
        password = ""
        newPassword = ""
        newPasswordRepeat = ""
    }
}

struct ChangePasswordForm_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        
        let user = AppUser.shared
        let users: [User] = try! controller.container.viewContext.fetch(User.fetchRequest())
        
       
        ChangePasswordForm()
            .padding(spacingLarge)
            .environment(\.managedObjectContext, controller.container.viewContext)
            .environmentObject(ViewRouter.shared)
            .environmentObject(user)
            .onAppear { user.login(users.first) }
    }
}
