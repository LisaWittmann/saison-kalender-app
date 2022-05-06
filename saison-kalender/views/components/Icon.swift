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
    
    @GestureState var press = false
    
    init(_ systemName: String, onTap: (() -> Void)? = nil, onPress: (() -> Void)? = nil) {
        self.systemName = systemName
        self.onTap = onTap
        self.onPress = onPress
    }
    
    var body: some View {
        GeometryReader { geometry in
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: geometry.globalWidth, height: geometry.globalHeight, alignment: .center)
                .onTapGesture {
                    if let function = onTap {
                        function()
                    }
                }
                .gesture(
                   LongPressGesture(minimumDuration: 0.5)
                       .updating($press) { currentState, gestureState, transaction in
                           gestureState = currentState
                       }
                       .onEnded { value in
                           if let function = onPress {
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
