//
//  AuthorizationView.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 02.05.22.
//

import SwiftUI

struct AuthorizationView: View {
    @Environment(\.managedObjectContext) var viewContext
    @EnvironmentObject var user: AppUser
    
    @State var registration = false
    @State var errorMessage: String? = nil
    
    var body: some View {
        Page {
            HStack {
                Headline(headline, "Dein Bereich")
                Image(systemName: "xmark")
                    .font(.custom(fontBold, size: fontSizeHeadline1))
                    .foregroundColor(colorGreen)
                    .onTapGesture { user.dismissAuthorization() }
            }
            Spacer()
            if registration {
                RegistrationForm(errorMessage: $errorMessage, toLogin: switchMode)
            } else {
                LoginForm(errorMessage: $errorMessage, toRegistration: switchMode)
            }
            Spacer()
            if let error = errorMessage {
                Text(error).modifier(FontError())
            }
            Spacer()
        }
    }
    
    private var headline: String {
        registration ? "Registrieren" : "Anmelden"
    }
    
    private func switchMode() {
        registration.toggle()
        errorMessage = nil
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        
        AuthorizationView()
            .environment(\.managedObjectContext, calendar.context)
            .environmentObject(AppUser())
            .environmentObject(ViewRouter())
            .environmentObject(calendar)
    }
}
