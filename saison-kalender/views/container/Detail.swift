//
//  SplitScreen.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct Detail<Content: View>: View {
    var image: String
    var headline: String
    var subline: String
    var close: () -> ()
    var icon: String
    var onIconTap: () -> ()
    
    var content: () -> Content
    
    init(
        image: String,
        headline: String = "",
        subline: String = "",
        close: @escaping () -> (),
        icon: String = "",
        onIconTap: @escaping () -> () = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.image = image
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
                        image: image,
                        close: close,
                        headline: headline,
                        subline: subline,
                        icon: icon,
                        onIconTap: onIconTap
                    )
                    Spacer()
                }
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
            .edgesIgnoringSafeArea(.all)
        }
        .modifier(PageLayout())
    }
    
    let headerHeight: CGFloat = 300
    let contentCornerRadius: CGFloat = 60
}

struct DetailHeader: View {
    var image: String
    var close: () -> ()
    var headline: String = ""
    var subline: String = ""
    var icon: String = ""
    var onIconTap: () -> () = {}
    
    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .scaledToFill()
                .opacity(imageOpacity)
                .frame(
                    width: screenWidth,
                    height: imageHeight,
                    alignment: .center
                )
            
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

struct SplitScreen_Previews: PreviewProvider {
    static var previews: some View {
        Detail(
            image: "Mangold",
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
