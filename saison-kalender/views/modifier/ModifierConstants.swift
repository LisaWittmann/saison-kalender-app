//
//  ModifierConstants.swift
//  saison-kalender
//
//  Created by Lisa Wittmann on 25.03.22.
//

import SwiftUI

extension UIScreen {
    static var screenWidth = UIScreen.main.bounds.size.width
    static var screenHeight = UIScreen.main.bounds.size.height
    static var screenSize =
        UIScreen.main.bounds.size
}

let contentWidth = UIScreen.screenWidth - spacingLarge * 2
let halfContentWidth = (contentWidth - spacingMedium) / 2
let quarterContentWidth = (contentWidth - spacingSmall) / 4

let spacingExtraSmall: CGFloat = 10
let spacingSmall: CGFloat = 15
let spacingMedium: CGFloat = 20
let spacingLarge: CGFloat = 35
let spacingExtraLarge: CGFloat = 45

let cornerRadiusSmall: CGFloat = 20
let cornerRadiusMedium: CGFloat = 22

let fontExtraBold = "Manrope-ExtraBold"
let fontSemiBold = "Manrope-SemiBold"
let fontBold = "Manrope-Bold"
let fontMedium = "Manrope-Medium"

let fontSizeTitle: CGFloat = 45
let fontSizeSubtitle: CGFloat = 26
let fontSizeHeadline1: CGFloat = 22
let fontSizeHeadline2: CGFloat = 18
let fontSizeText: CGFloat = 14

let colorGrey = Color("Grey")
let colorCurry = Color("Curry")
let colorBeige = Color("Beige")
let colorWhite = Color("White")
let colorBlack = Color("Black")
let colorGreen = Color("Green")
let colorLightGreen = Color("LightGreen")
