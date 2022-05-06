//
//  GeometryProxy+Size.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 06.05.22.
//

import Foundation
import SwiftUI

extension GeometryProxy {
    
    var globalWidth: CGFloat { frame(in: .global).width }
    var globalHeight: CGFloat { frame(in: .global).height }
    
    var localWidth: CGFloat { frame(in: .local).width }
    var localHeight: CGFloat { frame(in: .local).height }
}
