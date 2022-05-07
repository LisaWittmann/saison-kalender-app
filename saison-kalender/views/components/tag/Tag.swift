//
//  Tag.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Tag: View {
    var name: String
    var selected: Bool
    
    init(_ name: String, selected: Bool = false) {
        self.name = name
        self.selected = selected
    }
    
    var body: some View {
        Text(name)
            .padding(EdgeInsets(
                top: 5,
                leading: spacingSmall,
                bottom: 5,
                trailing: spacingSmall
            ))
            .modifier(FontText())
            .background(selected ? colorGreen : colorLightGreen)
            .cornerRadius(cornerRadiusMedium)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            Tag("Frühstück")
            Tag("Hauptspeise", selected: true)
        }
    }
}
