//
//  DetailPage.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

struct DetailPage<Title: View, Content: View>: View {
    var images: [String]
    
    var title: () -> Title
    var icon: (() -> Icon)?
    var content: () -> Content
    
    init(
        images: [String],
        title: @escaping () -> Title,
        icon: (() -> Icon)? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.images = images
        self.title = title
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
                    .blur(radius: 0.5)
                    .overlay(Rectangle().fill(colorBlack).opacity(0.3))
                    .frame(width: screenWidth, height: imageHeight)
                Spacer()
            }
            VStack {
                headerContent()
                Spacer()
            }
            .modifier(SectionLayout())
        }
        .frame(width: screenWidth, height: imageHeight, alignment: .topLeading)
    }
    
    
    @ViewBuilder
    private func headerContent() -> some View {
        HStack {
            VStack {
                Spacer()
                title().foregroundColor(colorWhite)
            }
            
            if let headerIcon = icon {
                VStack {
                    Spacer()
                    headerIcon()
                        .foregroundColor(colorWhite)
                        .frame(width: iconWidth, height: iconWidth)
                        .padding(.bottom, 5)
                }
            }
        }
        .padding(.bottom, textPadding)
        .frame(height: headerHeight, alignment: .bottom)
    }
    
    let textPadding: CGFloat = 70
    let headerHeight: CGFloat = 300
    let contentCornerRadius: CGFloat = 60
    let imageHeight: CGFloat = 400
    let imageOpacity: Double = 0.5
    let iconWidth: CGFloat = 30
}

struct DetailPage_Previews: PreviewProvider {
    static var previews: some View {
        DetailPage(
            images: ["mangold"],
            title: { Headline("Mangold", "Saisonal im Mai") },
            icon: { Icon("heart") }
        ) {
            Text("Steckbrief")
                .modifier(FontH1())
            Section("Wissenswertes") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ")
                    .modifier(FontParagraph())
            }
            Section("Ernte") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing.")
                    .modifier(FontParagraph())
            }
            Section("Anbauregion") {
                Text("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. ")
                    .modifier(FontParagraph())
            }
        }
    }
}
