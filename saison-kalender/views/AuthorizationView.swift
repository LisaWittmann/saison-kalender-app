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
        ZStack {
            if registration {
                Page {
                    HStack {
                        Headline("Registrieren", "Dein Bereich")
                            .foregroundColor(colorBlack)
                        Icon("xmark", onTap: user.dismissAuthorization)
                            .foregroundColor(colorGreen)
                            .frame(width: iconSize, height: iconSize)
                    }
                    Spacer()
                    RegistrationForm(toLogin: withAnimation {
                        { registration = false }
                    })
                }.transition(.customSlide(in: swipeDirection))
            }
            else {
                Page {
                    HStack {
                        Headline("Anmelden", "Dein Bereich")
                            .foregroundColor(colorBlack)
                        Icon("xmark", onTap: user.dismissAuthorization)
                            .foregroundColor(colorGreen)
                            .frame(width: iconSize, height: iconSize)
                    }
                    Spacer()
                    LoginForm(toRegistration: withAnimation {
                        { registration = true }
                    })
                }.transition(.customSlide(in: swipeDirection))
            }
        }.animation(.easeInOut(duration: 0.3), value: registration)
    }
    
    let iconSize: CGFloat = 25
    
    var swipeDirection: Edge {
        registration ? .trailing : .leading
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
