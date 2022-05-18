//
//  ChangeUserDataForm.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import SwiftUI

struct ChangeUserDataForm: View {
    @EnvironmentObject var user: AppUser
    
    @State var name = ""
    @State var email = ""
    
    var body: some View {
        VStack(spacing: spacingSmall) {
            InputField(user.name ?? "Name", text: $name, icon: "person.fill", validate: validName)
            InputField(user.email ?? "Email", text: $email, icon: "envelope.fill", validate: validEmail)
            SubmitButton("Daten aktualisieren", onSubmit: changeUserData, disabled: !validUserData)
        }
    }
    
    private func validName(_ name: String) -> Bool {
        name == "" || AppUser.isValidName(name)
    }
    
    private func validEmail(_ email: String) -> Bool {
        email == "" || AppUser.isValidEmail(email)
    }
    
    private var validUserData: Bool {
        AppUser.isValidName(name) || AppUser.isValidEmail(email)
    }
    
    private func changeUserData() {
        user.change(email: email, name: name)
        email = ""
        name = ""
    }
}

struct ChangeUserDataForm_Previews: PreviewProvider {
    static var previews: some View {
        let controller = PersistenceController.preview
        let users: [User] = try! controller.container.viewContext.fetch(User.fetchRequest())
        let user = AppUser.shared
        
        Page {
            Spacer()
            ChangeUserDataForm()
            Spacer()
        }
        .environment(\.managedObjectContext, controller.container.viewContext)
        .environmentObject(ViewRouter.shared)
        .environmentObject(user)
        .onAppear { user.login(users.first) }
    }
}
