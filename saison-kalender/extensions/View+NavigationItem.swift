//
//  View+NavigationItem.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Foundation
import SwiftUI

extension View {
    
    func navigationItem(_ name: String) -> some View {
        self
            .navigationBarHidden(true)
            .navigationBarTitle(Text(name))
            .edgesIgnoringSafeArea(.all)
    }
}
