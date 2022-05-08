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
            button("minus", action: remove)
            Text("|").foregroundColor(colorGreen)
            button("plus", action: add)
        }
        .background(colorLightGreen)
        .cornerRadius(cornerRadius)
    }
    
    @ViewBuilder
    private func button(_ icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: icon)
                .foregroundColor(colorBlack)
                .font(.custom(fontSemiBold, size: fontSizeText))
                .padding([.top, .bottom], spacingExtraSmall)
                .padding([.leading, .trailing], paddingHorizontal)
        }
    }
    
    let paddingHorizontal: CGFloat = 8
    let cornerRadius: CGFloat = 10
}

struct Stepper_Previews: PreviewProvider {
    static var previews: some View {
        Stepper(remove: {}, add: {})
    }
}
