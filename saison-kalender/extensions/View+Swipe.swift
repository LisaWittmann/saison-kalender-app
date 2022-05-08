//
//  View+Swipe.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 08.05.22.
//

import Foundation
import SwiftUI

extension View {

    func onSwipe(left: (() -> Void)? = nil, right: (() -> Void)? = nil) -> some View {
        self.highPriorityGesture(DragGesture(minimumDistance: 25, coordinateSpace: .local)
            .onEnded { value in
                if abs(value.translation.height) < abs(value.translation.width) {
                    if abs(value.translation.width) > 50.0 {
                        if let swipeToRight = right, value.translation.width < 0 {
                            swipeToRight()
                        } else if let swipeToLeft = left, value.translation.width > 0 {
                           swipeToLeft()
                        }
                    }
                }
            }
        )
    }
}
