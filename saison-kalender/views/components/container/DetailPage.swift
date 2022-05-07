//
//  DetailPage.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct DetailPage<Content: View>: View {
    @Environment(\.dismiss) var dismiss

    var images: [String]
    var headline: String?
    var subline: String?
    var icon: (() -> Icon)?
    var content: () -> Content
    
    init(
        images: [String],
        headline: String? = nil,
        subline: String? = nil,
        icon: (() -> Icon)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.images = images
        self.headline = headline
        self.subline = subline
        self.icon = icon
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
                        VStack(spacing: spacingLarge, content: content) .modifier(ContentLayout())
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
                ImageGroup(images)
                    .modifier(BlurredImageStyle())
                    .frame(width: screenWidth, height: imageHeight)
                Spacer()
            }
            VStack {
                navigationBar()
                headerContent()
                Spacer()
            }
            .modifier(SectionLayout())
        }
        .frame(width: screenWidth, height: imageHeight, alignment: .topLeading)
    }
    
    @ViewBuilder
    private func navigationBar() -> some View {
        HStack {
            Icon("arrow.left", onTap: { dismiss() })
                .foregroundColor(colorWhite)
                .frame(width: iconWidth, height: iconWidth)
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
            
            if let headerIcon = icon {
                VStack {
                    Spacer()
                    headerIcon()
                        .foregroundColor(colorWhite)
                        .frame(width: iconWidth, height: iconWidth)
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
            icon: { Icon("heart") }
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
