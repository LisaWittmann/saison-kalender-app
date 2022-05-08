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
                    .foregroundColor(colorBlack)
                Icon("xmark", onTap: close)
                    .frame(width: iconSize, height: iconSize)
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
                    icon(diet, size: iconSize(geometry))
                        .onTapGesture { user.change(diet: diet) }
                }
            }.frame(width: contentWidth, alignment: .leading)
        }.padding(.bottom, spacingExtraLarge)
    }
    
    @ViewBuilder
    private func icon(_ diet: Diet, size: CGFloat) -> some View {
        Image(diet.name.normalize())
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .opacity(iconOpacity(diet))
    }
    
    private func iconSize(_ geometry: GeometryProxy) -> CGFloat {
        geometry.size.width / CGFloat(Diet.allCases.count) - spacingSmall
    }
    
    private func iconOpacity(_ diet: Diet) -> Double {
        user.diets.contains(diet) ? 1 : inactiveOpacity
    }
    
    private func logout() {
        user.logout()
        viewRouter.navigate(to: .home)
    }
    
    let inactiveOpacity: Double = 0.5
    let iconSize: CGFloat = 25
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
