//
//  SplitScreen.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct Card<Content: View>: View {
    var images: [String]
    var headline: String
    var subline: String
    var close: () -> ()
    var icon: String
    var onIconTap: () -> ()
    
    var content: () -> Content
    
    init(
        images: [String],
        headline: String = "",
        subline: String = "",
        close: @escaping () -> (),
        icon: String = "",
        onIconTap: @escaping () -> () = {},
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
                    DetailHeader(
                        images: images,
                        close: close,
                        headline: headline,
                        subline: subline,
                        icon: icon,
                        onIconTap: onIconTap
                    )
                    Spacer()
                }
                .background(colorGreen)
            
                ZStack {
                    VStack(spacing: spacingLarge, content: content)
                        .frame(width: .infinity)
                        .frame(
                            minHeight: screenHeight - headerHeight,
                            alignment: .topLeading
                        )
                        .modifier(SectionLayout())
                }
                .frame(
                    width: screenWidth,
                    alignment: .topLeading
                )
                .background(colorBeige)
                .cornerRadius(contentCornerRadius, corners: [.topLeft, .topRight])
                .padding(.top, headerHeight)
            }
            .frame(
                minHeight: screenHeight,
                alignment: .topLeading
            )
        }
        .modifier(PageLayout())
    }
    
    let headerHeight: CGFloat = 300
    let contentCornerRadius: CGFloat = 60
}

struct DetailHeader: View {
    var images: [String]
    var close: () -> ()
    var headline: String = ""
    var subline: String = ""
    var icon: String = ""
    var onIconTap: () -> () = {}
    
    var body: some View {
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
                        VStack {
                            Text(subline)
                                .modifier(FontSubtitle())
                                .foregroundColor(colorWhite)
                            Text(headline)
                                .modifier(FontTitle())
                                .foregroundColor(colorWhite)
                        }
                        .frame(
                            height: headerHeight,
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
                            height: headerHeight,
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
    
    let headerHeight: CGFloat = 200
    let imageHeight: CGFloat = 400
    let imageOpacity: Double = 0.2
    let iconWidth: CGFloat = 30
}

struct Detail_Previews: PreviewProvider {
    static var previews: some View {
        Card(
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
