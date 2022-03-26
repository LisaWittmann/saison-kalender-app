//
//  SplitScreen.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct SplitScreen<Content: View>: View {
    var image: String
    var headline: String = ""
    var subline: String = ""
    var icon: String = ""
    var onIconTap: () -> () = {}
    
    var content: () -> Content
    
    var body: some View {
        ScrollView {
            ZStack {
                ZStack {
                    Image(image)
                        .resizable()
                        .scaledToFill()
                        .opacity(imageOpacity)
                        .frame(
                            width: UIScreen.screenWidth,
                            height: imageHeight,
                            alignment: .top
                        )
                    HStack {
                        VStack {
                            Text(subline)
                                .modifier(FontSubtitle())
                                .foregroundColor(colorWhite)
                            Text(headline)
                                .modifier(FontTitle())
                                .foregroundColor(colorWhite)
                        }
                        .frame(height: .infinity, alignment: .bottomLeading)
                        .offset(y: textOffset)
             
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(colorBeige)
                            .onTapGesture {
                                onIconTap()
                            }
                            .frame(width: iconWidth)
                            .offset(y: iconOffset)
                    }
                    .frame(
                        width: contentWidth,
                        height: headerHeight,
                        alignment: .bottomLeading
                    )
                }
                .modifier(FullScreenLayout())
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .background(colorGreen)
                
                Group {
                    VStack(spacing: spacingMedium, content: content)
                        .modifier(SectionLayout())
                        .frame(width: .infinity, alignment: .topLeading)
                }
                .modifier(FullScreenLayout())
                .background(colorBeige)
                .clipShape(RoundedRectangle(cornerRadius: contentCornerRadius))
                .offset(y: headerHeight)
            
            }
            .modifier(FullScreenLayout())
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .modifier(PageLayout())
    }
    
    let headerHeight: CGFloat = 300
    let textOffset: CGFloat = -30
    let iconOffset: CGFloat = -20
    let contentCornerRadius: CGFloat = 60
    let imageHeight: CGFloat = 340
    let imageOpacity: Double = 0.2
    let iconWidth: CGFloat = 30
}

struct SplitScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplitScreen(image: "Mangold", headline: "Linguine mit Mangold", icon: "heart") {
            Group {
                Text("Steckbrief")
                    .modifier(FontH1())
                Text("Wissenswertes")
                    .modifier(FontH2())
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim.")
                    .modifier(FontText())
                Text("Erntezeit")
                    .modifier(FontH2())
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.")
                    .modifier(FontText())
            }
        }
    }
}
