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
    
    var body: some View {
        Page {
            HStack {
                Headline("Bearbeiten", "Dein Bereich")
                Image(systemName: "xmark")
                    .font(.custom(fontBold, size: fontSizeHeadline1))
                    .foregroundColor(colorGreen)
                    .onTapGesture { close() }
            }
            Section("Ernährungsform") {
                changeDiet()
            }
            Section("Persönliche Daten") {
                ChangeUserDataForm()
            }
            Section("Passwort ändern") {
                ChangePasswordForm()
            }
            Button("Ausloggen", action: logout)
                .modifier(TextButtonStyle())
        }
    }
    
    @ViewBuilder
    private func changeDiet() -> some View {
        GeometryReader { geometry in
            HStack(spacing: spacingSmall) {
                ForEach(Diet.allCases, id: \.self) { diet in
                        Image(diet.name.lowercased())
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconSize(geometry), height: iconSize(geometry))
                            .opacity(iconOpacity(diet))
                            .onTapGesture { user.change(diet: diet) }
                }
            }.frame(width: contentWidth, alignment: .leading)
        }.padding(.bottom, spacingExtraLarge)
    }
    
    private func iconSize(_ geometry: GeometryProxy) -> CGFloat {
        geometry.globalWidth / CGFloat(Diet.allCases.count) - spacingSmall
    }
    
    private func iconOpacity(_ diet: Diet) -> Double {
        user.diets.contains(diet) ? 1 : inactiveOpacity
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
        let users: [User] = try! calendar.context.fetch(User.fetchRequest())
        
        AccountSettingsView(close: {})
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser(users.first))
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
