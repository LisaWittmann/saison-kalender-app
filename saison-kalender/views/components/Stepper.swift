//
//  Stepper.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 07.05.22.
//

import SwiftUI

struct Stepper: View {
    var remove: () -> Void
    var add: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            Button(action: remove) {
                Image(systemName: "minus")
            }
            .padding(padding)
            .foregroundColor(colorBlack)
            
            Text("|").foregroundColor(colorGreen)
            
            Button(action: add) {
                Image(systemName: "plus")
            }
            .padding(padding)
            .foregroundColor(colorBlack)
        }
        .background(colorLightGreen)
        .cornerRadius(cornerRadius)
    }
    
    let padding: CGFloat = 8
    let cornerRadius: CGFloat = 10
}

struct Stepper_Previews: PreviewProvider {
    static var previews: some View {
        Stepper(remove: {}, add: {})
    }
}
