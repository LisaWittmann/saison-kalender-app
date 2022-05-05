//
//  AccountSettingsView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 04.05.22.
//

import SwiftUI
import WrappingHStack

struct AccountSettingsView: View {
    @EnvironmentObject var user: AppUser
    @EnvironmentObject var viewRouter: ViewRouter
    
    var close: () -> Void
    
    @State var name = ""
    @State var email = ""
    
    @State var password = ""
    @State var newPassword = ""
    @State var newPasswordRepeat = ""
    
    var body: some View {
        Page {
            HStack {
                Headline("Bearbeiten", "Dein Bereich")
                Image(systemName: "xmark")
                    .font(.custom(fontBold, size: fontSizeHeadline1))
                    .foregroundColor(colorGreen)
                    .onTapGesture { close() }
            }
            editDiet()
            editUserData()
            editPassword()
            Button("Ausloggen", action: logout)
                .modifier(TextButtonStyle())
        }
    }
    
    @ViewBuilder
    private func editDiet() -> some View {
        Section("Ernährungsform") {
            GeometryReader { geometry in
                HStack(spacing: spacingSmall) {
                    ForEach(Diet.allCases, id: \.self) { diet in
                            Image(diet.name.lowercased())
                                .resizable()
                                .scaledToFit()
                                .frame(width: iconSize(geometry), height: iconSize(geometry))
                                .opacity(iconOpacity(diet))
                                .onTapGesture { user.update(diet: diet) }
                    }
                }.frame(width: contentWidth, alignment: .leading)
            }.padding(.bottom, spacingExtraLarge)
        }
    }
    
    private func iconSize(_ geometry: GeometryProxy) -> CGFloat {
        geometry.frame(in: .global).width / CGFloat(Diet.allCases.count) - spacingSmall
    }
    
    private func iconOpacity(_ diet: Diet) -> Double {
        user.diets.contains(diet) ? 1 : inactiveOpacity
    }
    
    @ViewBuilder
    private func editUserData() -> some View {
        Section("Persönliche Daten") {
            VStack(spacing: spacingSmall) {
                InputField(user.name ?? "Name", text: $name, icon: "person.fill", validate: AppUser.isValidName)
                InputField(user.email ?? "Email", text: $email, icon: "envelope.fill", validate: AppUser.isValidEmail)
                SubmitButton("Daten aktualisieren", onSubmit: { user.change(email: email, name: name) }, disabled: !validUserData)
            }
        }
    }
    
    @ViewBuilder
    private func editPassword() -> some View {
        Section("Passwort ändern") {
            VStack(spacing: spacingSmall) {
                InputField("Altes Passwort", text: $password, icon: "lock.fill", secure: true, validate: user.checkPassword)
                InputField("Neues Passwort", text: $newPassword, icon: "lock.fill", secure: true, validate: AppUser.isValidPassword)
                InputField("Passwort wiederholen", text: $newPasswordRepeat, icon: "lock.fill", secure: true, validate: { pw in newPassword == pw })
                SubmitButton("Passwort aktualisieren", onSubmit: { user.changePassword(newPassword) }, disabled: !validPassword)
            }
        }
    }
    
    private var validUserData: Bool {
        AppUser.isValidName(name) || AppUser.isValidEmail(email)
    }
    
    private var validPassword: Bool {
        AppUser.isValidPassword(newPassword) && user.checkPassword(password) && newPassword == newPasswordRepeat
    }
    
    private func logout() {
        user.logout()
        viewRouter.currentView = .home
    }
    
    let inactiveOpacity: Double = 0.5
}

struct AccountSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        AccountSettingsView(close: {})
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
