//
//  ContextMenuManager.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Combine
import SwiftUI

class ContextMenuManager: ObservableObject {
    
    var slideAnimation: SlideAnimation
    var menuStyle: MenuStyle = .defaultStyle()
    
    private(set) var onDismiss: (() -> Void)?
    
    @Published private(set) var content: AnyView
    @Published var isPresented: Bool = false {
        didSet {
            if !isPresented {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
                    self?.content = EmptyView().eraseToAnyView()
                    self?.onDismiss = nil
                }
            }
        }
    }
    
    init() {
        content = EmptyView().eraseToAnyView()
        slideAnimation = SlideAnimation()
    }
    
    func updateContextMenu<Content: View>(
        isPresented: Bool,
        style: MenuStyle,
        slideAnimation: SlideAnimation?,
        content: @escaping () -> Content,
        onDismiss: @escaping () -> Void) {
            self.content = AnyView(content())
            self.menuStyle = style
            self.onDismiss = onDismiss
            self.slideAnimation = slideAnimation ?? SlideAnimation()
            withAnimation(isPresented ? self.slideAnimation.slideIn : self.slideAnimation.slideOut) {
                self.isPresented = isPresented
            }
        }
    
}

struct MenuStyle {
    var background: Color
    var cornerRadius: CGFloat
    
    static func defaultStyle() -> MenuStyle {
        .init(background: Color(UIColor.systemBackground), cornerRadius: 10)
    }
}

struct SlideAnimation {
    var slideIn: Animation
    var slideOut: Animation
    
    private(set) var defaultSlideAnimation: Animation = {
        .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)
    }()
    
    init(slideIn: Animation? = nil, slideOut: Animation? = nil) {
        self.slideIn = slideIn ?? defaultSlideAnimation
        self.slideOut = slideOut ?? defaultSlideAnimation
    }
}

