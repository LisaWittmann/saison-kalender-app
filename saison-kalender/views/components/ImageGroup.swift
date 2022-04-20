//
//  ImageGroup.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 01.04.22.
//

import SwiftUI

struct ImageGroup: View {
    var images: [String]
    var width: CGFloat
    var height: CGFloat
    
    init(_ images: [String], width: CGFloat = screenWidth, height: CGFloat = 300) {
        self.images = images
        self.width = width
        self.height = height
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(images.first ?? "")
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(
                    width: firstImageWidth,
                    height: height,
                    alignment: firstImageAlignment
                )
                .clipped()
            if images.count >= 3 {
                VStack(spacing: 0) {
                    
                    Image(images[1])
                        .resizable()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .frame(
                            width: screenWidth / 3 * 1,
                            height: height / 2,
                            alignment: .leading
                        )
                        .clipped()
                    
                    Image(images[2])
                        .resizable()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .frame(
                            width: screenWidth / 3 * 1,
                            height: height / 2,
                            alignment: .leading
                        )
                        .clipped()
                    
                }
            }
        }
        .background(colorLightGreen)        
    }
    
    var firstImageWidth: CGFloat {
        if images.count >= 3 {
            return width / 3 * 2
        }
        return width
    }
    
    var firstImageAlignment: Alignment {
        if images.count >= 3 {
            return .trailing
        }
        return .center
    }
    
    let imageOpacity: Double = 0.7
}


struct ImageGroup_Previews: PreviewProvider {
    static var previews: some View {
        let calendar = SeasonCalendar.preview
        let images = calendar.recipes.map({ $0.slug })
        
        ScrollView {
            VStack {
                ImageGroup(images)
                ImageGroup(Array(images[0...1]))
            }
        }
    }
}
