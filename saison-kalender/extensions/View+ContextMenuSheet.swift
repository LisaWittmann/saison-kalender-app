//
//  View+ContextMenuSheet.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 20.04.22.
//

import Foundation
import SwiftUI

extension View {
    
    func contextMenuSheet<Content: View>(
        isPresented: Binding<Bool>,
        menuStyle: MenuStyle,
        slideAnimation: SlideAnimation? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        ContextMenuManagerWrapper(
            isPresented: isPresented,
            menuStyle: menuStyle,
            slideAnimation: slideAnimation,
            content: content,
            parent: self
        )
    }
}

struct ContextMenuManagerWrapper<Parent: View, MenuContent: View>: View {
    @EnvironmentObject var manager: ContextMenuManager
    
    @Binding var isPresented: Bool
    let menuStyle: MenuStyle
    let slideAnimation: SlideAnimation?
    let content: () -> MenuContent
    let parent: Parent
    
    var body: some View {
        parent
            .onChange(of: isPresented, perform: {_ in updateContent() })
    }
    
    private func updateContent() {
        manager.updateContextMenu(
            isPresented: isPresented,
            style: menuStyle,
            slideAnimation: slideAnimation,
            content: content,
            onDismiss: { self.isPresented = false}
        )
    }
    
}
