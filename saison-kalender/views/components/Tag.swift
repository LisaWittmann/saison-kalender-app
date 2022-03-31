//
//  Tag.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 31.03.22.
//

import SwiftUI

struct Tag: View {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
    
    var body: some View {
        Text(name)
            .padding(EdgeInsets(
                top: 5,
                leading: spacingSmall,
                bottom: 5,
                trailing: spacingSmall
            ))
            .font(.custom(fontMedium, size: fontSizeText))
            .background(colorLightGreen)
            .cornerRadius(cornerRadiusMedium)
    }
}

struct Tag_Previews: PreviewProvider {
    static var previews: some View {
        Tag("Frühstück")
    }
}
