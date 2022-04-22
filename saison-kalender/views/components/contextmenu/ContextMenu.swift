//
//  ContextMenu.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Combine
import SwiftUI

struct ContextMenu: ViewModifier {
    @EnvironmentObject var manager: ContextMenuManager
    @Environment(\.safeAreaInsets) var safeAreaInsets
    
    @State var sheetContentRect: CGRect = .zero
    @State var keyboardOffset: CGFloat = 0
    @State private var presenterContentRect: CGRect = .zero
    
    var topAnchor: CGFloat {
        presenterContentRect.height + safeAreaInsets.top - sheetContentRect.height
    }
    
    var bottomAnchor: CGFloat {
        UIScreen.main.bounds.height
    }
    
    private var menuStyle: MenuStyle { manager.menuStyle }
    
    private var menuPosition: CGFloat {
        if self.manager.isPresented {
            let topInset = safeAreaInsets.top
            let position = self.topAnchor - self.keyboardOffset
            
            if position < topInset {
                return topInset
            }
            return position
        } else {
            return self.bottomAnchor
        }
    }
    
    @ViewBuilder private var background: some View {
        Rectangle().fill(menuStyle.background)
    }
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .onAppear{ addKeyboardNotifier() }
                .onDisappear { removeKeyboardNotifier() }
                .onFrameDidChange { prefData in
                    withAnimation {
                        self.presenterContentRect = prefData.first?.bounds ?? .zero
                    }
                }
            menuSheet().edgesIgnoringSafeArea(.vertical)
        }
    }
}

extension ContextMenu {
    
    func removeKeyboardNotifier() {
        let notifier = NotificationCenter.default
        notifier.removeObserver(self)
    }

    func addKeyboardNotifier() {
        let notifier = NotificationCenter.default
        let willShow = UIResponder.keyboardWillShowNotification
        let willHide = UIResponder.keyboardWillHideNotification
        notifier.addObserver(
            forName: willShow,
            object: nil,
            queue: .main,
            using: self.keyboardShow
        )
        notifier.addObserver(
            forName: willHide,
            object: nil,
            queue: .main,
            using: self.keyboardHide
        )
    }

    func dismissKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        DispatchQueue.main.async {
            UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
        }
    }

    private func keyboardShow(notification: Notification) {
        let endFrame = UIResponder.keyboardFrameEndUserInfoKey
        if let rect: CGRect = notification.userInfo![endFrame] as? CGRect {
            let height = rect.height
            let bottomInset = safeAreaInsets.bottom
            withAnimation(manager.slideAnimation.defaultSlideAnimation) {
                self.keyboardOffset = height - bottomInset
            }
        }
    }

    private func keyboardHide(notification: Notification) {
        DispatchQueue.main.async {
            withAnimation(manager.slideAnimation.defaultSlideAnimation) {
                self.keyboardOffset = 0
            }
        }
    }
}

extension ContextMenu {
    
    private func menuSheet()-> some View {
        let sheetContent = self.manager.content
            .trackFrame()
            
        return ZStack {
            if manager.isPresented {
                Group {
                    EmptyView()
                }
                .edgesIgnoringSafeArea(.vertical)
                .onTapGesture { dismissSheet() }
            }
            
            VStack {
                sheetContent
                Spacer()
            }
            .onFrameDidChange { prefData in
                let animation = prefData.first?.bounds != nil ? self.manager.slideAnimation.slideIn : self.manager.slideAnimation.slideOut

                guard let bounds = prefData.first?.bounds else {
                    withAnimation(animation) {
                        self.sheetContentRect = .zero
                    }
                    return
                }
                withAnimation(animation) {
                    self.sheetContentRect = bounds
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .background(self.background)
            .cornerRadius(menuStyle.cornerRadius)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
            .offset(y: self.menuPosition)
            .onTapGesture {}
        }
    }

    private func dismissSheet() {
        withAnimation(manager.slideAnimation.slideOut) {
            self.manager.isPresented = false
            self.dismissKeyboard()
            self.manager.onDismiss?()
        }
    }
}
