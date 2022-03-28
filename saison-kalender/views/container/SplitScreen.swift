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
                    SplitScreenHeader(
                        image: image,
                        headline: headline,
                        subline: subline,
                        icon: icon,
                        onIconTap: onIconTap
                    )
                }
                .modifier(FullScreenLayout())
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .background(colorGreen)
                .offset(y: -imageOffset)

            
                ZStack {
                    VStack(spacing: spacingLarge, content: content)
                        .frame(width: .infinity)
                        .frame(
                            minHeight: UIScreen.screenHeight,
                            alignment: .topLeading
                        )
                        .modifier(SectionLayout())
                }
                .frame(
                    width: UIScreen.screenWidth,
                    alignment: .topLeading
                )
                .background(colorBeige)
                .clipShape(RoundedRectangle(
                    cornerRadius: contentCornerRadius
                ))
                .padding(.top, headerHeight)
                
            }
            .frame(
                minHeight: UIScreen.screenHeight,
                alignment: .topLeading
            )
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
        .modifier(PageLayout())
    }
    
    let headerHeight: CGFloat = 300
    let imageOffset: CGFloat = 270
    let contentCornerRadius: CGFloat = 60
}

struct SplitScreenHeader: View {
    var image: String
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
                    width: UIScreen.screenWidth,
                    height: imageHeight,
                    alignment: .center
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
                .frame(
                    maxHeight: .infinity,
                    alignment: .bottomLeading
                )
              
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(colorBeige)
                    .onTapGesture { onIconTap() }
                    .frame(width: iconWidth)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, spacingExtraSmall)
            }
            .frame(
                width: contentWidth,
                height: headerHeight,
                alignment: .bottomLeading
            )
        }
    }
    
    let headerHeight: CGFloat = 300
    let imageHeight: CGFloat = 400
    let imageOpacity: Double = 0.2
    let iconWidth: CGFloat = 30
}

struct SplitScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplitScreen(image: "Mangold", headline: "Mangold", subline: "Saisonal im März", icon: "heart") {
            Group {
                Text("Steckbrief")
                    .modifier(FontH1())
                Text("Wissenswertes")
                    .modifier(FontH2())
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ")
                    .modifier(FontText())
                Text("Ernte")
                    .modifier(FontH2())
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.")
                    .modifier(FontText())
                Text("Anbauregion")
                    .modifier(FontH2())
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ")
                    .modifier(FontText())
            }
        }
    }
}
