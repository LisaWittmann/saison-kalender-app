//
//  ImageGroup.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct ImageGroup: View {
    var images: [String]
    
    init(_ images: [String]) {
        self.images = images
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                image(images.first ?? "",
                      width: firstImageWidth(geometry: geometry),
                      height: geometry.size.height,
                      alignment: firstImageAlignment
                )
                if images.count >= 3 {
                    VStack(spacing: 0) {
                        image(images[1],
                              width: geometry.size.width / 3,
                              height: geometry.size.height / 2,
                              alignment: .leading
                        )
                        image(images[2],
                              width: geometry.size.width / 3,
                              height: geometry.size.height / 2,
                              alignment: .leading
                        )
                    }
                }
            }
            .background(colorLightGreen)
        }
    }
    
    @ViewBuilder
    private func image(_ name: String, width: CGFloat, height: CGFloat, alignment: Alignment) -> some View {
        Image(name)
            .resizable()
            .scaledToFill()
            .opacity(imageOpacity)
            .frame(width: width, height: height, alignment: alignment)
            .clipped()
    }
    
    private func firstImageWidth(geometry: GeometryProxy) -> CGFloat {
        images.count >= 3 ? geometry.size.width / 3 * 2 : geometry.size.width
    }
    
    private var firstImageAlignment: Alignment {
        images.count >= 3 ? .trailing : .center
    }
    
    let imageOpacity: Double = 0.7
}


struct ImageGroup_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let images = calendar.recipes.map { $0.name.normalize() }
        
        ScrollView {
            VStack {
                ImageGroup(images)
                    .frame(width: screenWidth, height: 300)
                ImageGroup(Array(images[0...1]))
                    .frame(width: screenWidth, height: 300)
            }
        }
    }
}
