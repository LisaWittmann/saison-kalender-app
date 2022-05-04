//
//  Masonry.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 14.04.22.
//

import SwiftUI
import SwiftUIMasonry

struct Masonry<Element, Content: View>: View where Element : Equatable, Hashable {
    var columns: Int
    var elements: [Element]
    var content: (Element, Bool?) -> Content
    
    var body: some View {
        VMasonry(columns: columns, spacing: spacingMedium) {
            ForEach(Array(elements), id: \.self) { element in
                content(element, isLarge(element))
            }
        }
    }
    
    private func isLarge(_ element: Element) -> Bool {
        let index = elements.firstIndex(of: element)!
        return !(index % (columns * 2) == 0 ||
            (index+1) % (columns * 2) == 0)
    }
}

/*struct Masonry_Previews: PreviewProvider {
    static var previews: some View {
        Masonry()
    }
}*/
