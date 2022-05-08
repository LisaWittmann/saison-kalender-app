//
//  Icon.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import SwiftUI

struct Icon: View {
    var systemName: String
    var onTap: (() -> Void)?
    var onPress: (() -> Void)?
    var disabled: Bool
    
    @GestureState var press = false
    
    init(_ systemName: String, onTap: (() -> Void)? = nil, onPress: (() -> Void)? = nil, disabled: Bool = false) {
        self.systemName = systemName
        self.onTap = onTap
        self.onPress = onPress
        self.disabled = disabled
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                .opacity(disabled ? 0.5 : 1)
                .onTapGesture {
                    if let function = onTap, !disabled {
                        function()
                    }
                }
                .gesture(
                   LongPressGesture(minimumDuration: 0.5)
                       .updating($press) { currentState, gestureState, transaction in
                           gestureState = currentState
                       }
                       .onEnded { value in
                           if let function = onPress, !disabled {
                               function()
                           }
                       }
               )
        }
    }
}

struct Icon_Previews: PreviewProvider {
    static var previews: some View {
        Icon("xmark")
            .frame(width: 30, height: 30)
    }
}
