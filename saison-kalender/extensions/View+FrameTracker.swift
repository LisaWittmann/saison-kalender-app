//
//  View+FrameTracker.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Foundation
import SwiftUI

struct AddFrameTracker: ViewModifier {

    struct PresenterPreferenceKey: PreferenceKey {
        static func reduce(value: inout [PreferenceData], nextValue: () -> [PreferenceData]) {
            value.append(contentsOf: nextValue())
        }
        static var defaultValue: [PreferenceData] = []
    }

    struct SheetPreferenceKey: PreferenceKey {
        static func reduce(value: inout [PreferenceData], nextValue: () -> [PreferenceData]) {
            value.append(contentsOf: nextValue())
        }
        static var defaultValue: [PreferenceData] = []
    }

    struct PreferenceData: Equatable {
        let bounds: CGRect
    }

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear.preference(
                        key: PresenterPreferenceKey.self,
                        value: [PreferenceData(bounds: proxy.frame(in: .global))]
                    )
                }
            )
    }
}

struct OnFrameDidChange: ViewModifier {
    var onChange: ([AddFrameTracker.PreferenceData]) -> Void

    func body(content: Content) -> some View {
        content
            .onPreferenceChange(AddFrameTracker.PresenterPreferenceKey.self, perform: { (prefData) in
                DispatchQueue.main.async {
                    onChange(prefData)
                }
            })
    }
}

extension View {
    func trackFrame() -> some View {
        self.modifier(AddFrameTracker())
    }

    func onFrameDidChange(_ onChange: @escaping ([AddFrameTracker.PreferenceData]) -> Void) -> some View {
        self.modifier(OnFrameDidChange(onChange: onChange))
    }
}
