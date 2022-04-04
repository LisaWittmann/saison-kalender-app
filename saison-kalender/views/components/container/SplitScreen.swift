//
//  SplitScreen.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct SplitScreen<Content: View>: View {
    var images: [String]
    var headline: String
    var subline: String
    var close: () -> ()
    var icon: String
    var onIconTap: () -> Void
    var content: () -> Content
    
    init(
        images: [String],
        headline: String = "",
        subline: String = "",
        close: @escaping () -> Void,
        icon: String = "",
        onIconTap: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.images = images
        self.headline = headline
        self.subline = subline
        self.close = close
        self.icon = icon
        self.onIconTap = onIconTap
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    header
                    Spacer()
                }
                .background(colorGreen)
            
                ZStack {
                    VStack {
                        VStack(spacing: spacingLarge, content: content)
                            .frame(width: .infinity)
                            .modifier(SectionLayout())
                        Spacer()
                    }
                }
                .frame(
                    width: screenWidth,
                    alignment: .topLeading
                )
                .background(colorBeige)
                .cornerRadius(contentCornerRadius, corners: [.topLeft, .topRight])
                .padding(.top, headerHeight)
            }
        }
        .modifier(PageLayout())
    }
    
    
    var header: some View {
        ZStack {
            ImageGroup(images, height: imageHeight)
                VStack {
                    HStack {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: iconWidth)
                            .foregroundColor(colorWhite)
                            .onTapGesture { close() }
                        Spacer()
                    }
                    
                    HStack {
                        Headline(headline, subline, color: colorWhite)
                        .frame(
                            height: imageHeight/2,
                            alignment: .bottom
                        )
                        VStack {
                            Image(systemName: icon)
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(colorWhite)
                                .onTapGesture { onIconTap() }
                                .frame(width: iconWidth)
                        }.frame(
                            height: imageHeight/2,
                            alignment: .bottom
                        )
                        .padding(.bottom, spacingExtraSmall)
                    }
                    Spacer()
                }
                .modifier(SectionLayout())
            }
            .frame(
                width: screenWidth,
                height: imageHeight,
                alignment: .topLeading
            )
    }
    
    let headerHeight: CGFloat = 300
    let contentCornerRadius: CGFloat = 60
    let imageHeight: CGFloat = 400
    let imageOpacity: Double = 0.2
    let iconWidth: CGFloat = 30
}

struct SplitScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplitScreen(
            images: ["Mangold"],
            headline: "Mangold",
            subline: "Saisonal im März",
            close: {},
            icon: "heart"
        ) {
            
            Text("Steckbrief")
                .modifier(FontH1())
            Section("Wissenswertes") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ").modifier(FontText())
            }
            Section("Ernte") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.").modifier(FontText())
            }
            Section("Anbauregion") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ").modifier(FontText())
            }
        }
    }
}
