//
//  DetailPage.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct DetailPage<Content: View>: View {
    var images: [String]
    var headline: String?
    var subline: String?
    var close: () -> ()
    var icon: String?
    var onIconTap: () -> Void
    var onIconPressed: () -> Void
    var content: () -> Content
    
    @GestureState var press = false
    
    init(
        images: [String],
        headline: String? = nil,
        subline: String? = nil,
        close: @escaping () -> Void,
        icon: String? = nil,
        onIconTap: @escaping () -> Void = {},
        onIconPressed: @escaping () -> Void = {},
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.images = images
        self.headline = headline
        self.subline = subline
        self.close = close
        self.icon = icon
        self.onIconTap = onIconTap
        self.onIconPressed = onIconPressed
        self.content = content
    }
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    header
                    Spacer()
                }.background(colorGreen)
            
                Group {
                    VStack {
                        VStack(spacing: spacingLarge, content: content)
                            .modifier(ContentLayout())
                        Spacer()
                    }
                }
                .frame(width: screenWidth, alignment: .topLeading)
                .background(colorBeige)
                .cornerRadius(contentCornerRadius, corners: [.topLeft, .topRight])
                .padding(.top, headerHeight)
            }
        }
        .modifier(PageLayout())
    }
    
    
    var header: some View {
        ZStack {
            VStack {
                ImageGroup(images, height: imageHeight)
                    .modifier(BlurredImageStyle())
                Spacer()
            }
            VStack {
                navigationBar()
                headerContent()
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
    
    @ViewBuilder
    private func navigationBar() -> some View {
        HStack {
            Image(systemName: "arrow.left")
                .resizable()
                .scaledToFit()
                .frame(height: iconWidth)
                .foregroundColor(colorWhite)
                .onTapGesture { close() }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func headerContent() -> some View {
        HStack {
            VStack {
                if let subtitle = subline {
                    Text(subtitle)
                        .modifier(FontSubtitle())
                        .foregroundColor(colorWhite)
                        .padding(.bottom, -spacingMedium)
                }
                if let title = headline {
                    Text(title)
                        .modifier(FontTitle())
                        .foregroundColor(colorWhite)
                }
                    
            }.frame(height: textHeight, alignment: .bottom)
            
            if let systemName = icon {
                VStack {
                    Image(systemName: systemName)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(colorWhite)
                        .onTapGesture { onIconTap() }
                        .frame(width: iconWidth)
                        .gesture(
                           LongPressGesture(minimumDuration: 0.5)
                               .updating($press) { currentState, gestureState, transaction in
                                   gestureState = currentState
                               }
                               .onEnded { value in
                                   onIconPressed()
                               }
                       )
                }
                .frame(height: textHeight, alignment: .bottom)
                .padding(.bottom, spacingMedium)
            }
        }
    }
    
    let textHeight: CGFloat = 180
    let headerHeight: CGFloat = 300
    let contentCornerRadius: CGFloat = 60
    let imageHeight: CGFloat = 400
    let imageOpacity: Double = 0.5
    let iconWidth: CGFloat = 30
}

struct SplitScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(
            images: ["mangold"],
            headline: "Mangold",
            subline: "Saisonal im Mai",
            close: {},
            icon: "heart"
        ) {
            
            Text("Steckbrief")
                .modifier(FontH1())
            Section("Wissenswertes") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ").modifier(FontParagraph())
            }
            Section("Ernte") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.").modifier(FontParagraph())
            }
            Section("Anbauregion") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ").modifier(FontParagraph())
            }
        }
    }
}
