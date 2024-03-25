//
//  Constants.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import Foundation
import UIKit
import SwiftUI

/**
 All constants of the whole application are stored in this file.
 */
struct Constant {
    public struct AppString {
        static let kOverView: String                            = "Overview"
        static let kIncome: String                              = "Income"
        static let kNeeds: String                               = "Needs"
        static let kReceived: String                            = "received"
        static let kExpected: String                            = "more expected"
        static let kWants: String                               = "Wants"
        static let kSave: String                                = "Save"
        static let kSaved: String                               = "saved"
        static let kLeft: String                                = "left"
        static let kSpent: String                               = "spent"
        static let kPercentageBreakdown: String                 = "% Breakdown"
        static let k503020String: String                        = "50/30/20 recommended"
        static let kTapHereToLearnWhy: String                   = "Tap here to learn why"
        static let kWebURL: String                              = "https://www.investopedia.com/ask/answers/022916/what-502030-budget-rule.asp"
    }
}

extension Constant {
    public struct AppImage {
        static let kBack: String                                = "chevron.backward"
    }
}

///`FontSize`
extension Constant {
    struct FontSize {

        static let _9FontSize: CGFloat                  = DeviceType.IsDeviceIPad ? 15 : 9
        static let _10FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 16 : 10
        static let _11FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 17 : 11
        static let _12FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 18 : 12
        static let _13FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 19 : 13
        static let _14FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 20 : 14
        static let _15FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 21 : 15
        static let _16FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 22 : 16
        static let _17FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 23 : 17
        static let _18FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 24 : 18
        static let _20FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 26 : 20
        static let _22FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 28 : 22
        static let _25FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 31 : 25
        static let _28FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 34 : 28
        static let _30FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 36 : 30
        static let _33FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 39 : 33
        static let _34FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 44 : 34
        static let _40FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 50 : 40
        static let _48FontSize: CGFloat                 = DeviceType.IsDeviceIPad ? 54 : 48

        static let defaultFontSize: CGFloat             = DeviceType.IsDeviceIPad ? 22 : 16
        static let headerSize: CGFloat                  = DeviceType.IsDeviceIPad ? 38 : 34
        static let navTitleFontSize: CGFloat            = DeviceType.IsDeviceIPad ? 34 : 30
        static let calendarFontSize: CGFloat            = DeviceType.IsDeviceIPad ? 23 : 17
    }
}

///`setFrame`
extension Constant {
    struct setFrame {
        static let _1Size: CGFloat                     = DeviceType.IsDeviceIPad ? 2.0 : 1.0
        static let _2Size: CGFloat                     = DeviceType.IsDeviceIPad ? 4.0 : 2.0
        static let _5Size: CGFloat                     = DeviceType.IsDeviceIPad ? 10.0 : 5.0
        static let _8Size: CGFloat                     = DeviceType.IsDeviceIPad ? 16.0 : 8.0
        static let _9Size: CGFloat                     = DeviceType.IsDeviceIPad ? 19.0 : 9.0
        static let _10Size: CGFloat                    = DeviceType.IsDeviceIPad ? 20.0 : 10.0
        static let _12Size: CGFloat                    = DeviceType.IsDeviceIPad ? 22.0 : 12.0
        static let _14Size: CGFloat                    = DeviceType.IsDeviceIPad ? 24.0 : 14.0
        static let _15Size: CGFloat                    = DeviceType.IsDeviceIPad ? 25.0 : 15.0
        static let _17Size: CGFloat                    = DeviceType.IsDeviceIPad ? 27.0 : 17.0
        static let _18Size: CGFloat                    = DeviceType.IsDeviceIPad ? 28.0 : 18.0
        static let _19Size: CGFloat                    = DeviceType.IsDeviceIPad ? 29.0 : 19.0
        static let _20Size: CGFloat                    = DeviceType.IsDeviceIPad ? 40.0 : 20.0
        static let _21Size: CGFloat                    = DeviceType.IsDeviceIPad ? 31.0 : 21.0
        static let _23Size: CGFloat                    = DeviceType.IsDeviceIPad ? 33.0 : 23.0
        static let _24Size: CGFloat                    = DeviceType.IsDeviceIPad ? 34.0 : 24.0
        static let _25Size: CGFloat                    = DeviceType.IsDeviceIPad ? 35.0 : 25.0
        static let _26Size: CGFloat                    = DeviceType.IsDeviceIPad ? 36.0 : 26.0
        static let _27Size: CGFloat                    = DeviceType.IsDeviceIPad ? 31.0 : 27.0
        static let _28Size: CGFloat                    = DeviceType.IsDeviceIPad ? 38.0 : 28.0
        static let _30Size: CGFloat                    = DeviceType.IsDeviceIPad ? 40.0 : 30.0
        static let _34Size: CGFloat                    = DeviceType.IsDeviceIPad ? 50.0 : 34.0
        static let _35Size: CGFloat                    = DeviceType.IsDeviceIPad ? 45.0 : 35.0
        static let _40Size: CGFloat                    = DeviceType.IsDeviceIPad ? 50.0 : 40.0
        static let _44Size: CGFloat                    = DeviceType.IsDeviceIPad ? 54.0 : 44.0
        static let _49Size: CGFloat                    = DeviceType.IsDeviceIPad ? 59.0 : 49.0
        static let _50Size: CGFloat                    = DeviceType.IsDeviceIPad ? 60.0 : 50.0
        static let _52Size: CGFloat                    = DeviceType.IsDeviceIPad ? 104.0 : 52.0
        static let _55Size: CGFloat                    = DeviceType.IsDeviceIPad ? 65.0 : 55.0
        static let _60Size: CGFloat                    = DeviceType.IsDeviceIPad ? 70.0 : 60.0
        static let _66Size: CGFloat                    = DeviceType.IsDeviceIPad ? 76.0 : 66.0
        static let _70Size: CGFloat                    = DeviceType.IsDeviceIPad ? 80.0 : 70.0
        static let _72Size: CGFloat                    = DeviceType.IsDeviceIPad ? 82.0 : 72.0
        static let _75Size: CGFloat                    = DeviceType.IsDeviceIPad ? 85.0 : 75.0
        static let _79Size: CGFloat                    = DeviceType.IsDeviceIPad ? 89.0 : 79.0
        static let _80Size: CGFloat                    = DeviceType.IsDeviceIPad ? 90.0 : 80.0
        static let _84Size: CGFloat                    = DeviceType.IsDeviceIPad ? 94.0 : 84.0
        static let _90Size: CGFloat                    = DeviceType.IsDeviceIPad ? 100.0 : 90.0
        static let _100Size: CGFloat                   = DeviceType.IsDeviceIPad ? 110.0 : 100.0
        static let _120Size: CGFloat                   = DeviceType.IsDeviceIPad ? 140.0 : 120.0
        static let _142Size: CGFloat                   = DeviceType.IsDeviceIPad ? 172.0 : 142.0
        static let _180Size: CGFloat                   = DeviceType.IsDeviceIPad ? 200.0 : 180.0
        static let _200Size: CGFloat                   = DeviceType.IsDeviceIPad ? 220.0 : 200.0


        static let _50SizeLarge: CGFloat                    = DeviceType.IsDeviceIPad ? 100.0 : 50.0

        static let _NavigationItemSize: CGFloat        = DeviceType.IsDeviceIPad ? 40.0 : 30.0
        static let _EditIconSize: CGFloat              = DeviceType.IsDeviceIPad ? 30.0 : 20.0

    }
}


///`setSpace`
extension Constant {
    struct setSpace {
        static let _0_5Padding: CGFloat                 = DeviceType.IsDeviceIPad ? 1 : 0.5
        static let _2Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 4 : 2
        static let _3Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 6 : 3
        static let _4Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 8 : 4
        static let _5Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 10 : 5
        static let _6Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 12 : 6
        static let _7Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 14 : 7
        static let _8Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 16 : 8
        static let _9Padding: CGFloat                   = DeviceType.IsDeviceIPad ? 18 : 9
        static let _10Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 20 : 10
        static let _12Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 24 : 12
        static let _14Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 28 : 14
        static let _16Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 32 : 16
        static let _18Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 36 : 18
        static let _20Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 40 : 20
        static let _25Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 50 : 25
        static let _30Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 60 : 30
        static let _36Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 72 : 36
        static let _48Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 96 : 48
        static let _50Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 100 : 50
        static let _60Padding: CGFloat                  = DeviceType.IsDeviceIPad ? 120 : 60
    }
}

// MARK: - iPhone devicetype
struct DeviceType {
    static let IS_IPHONE_4_OR_LESS      = ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5              = ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6              = ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P             = ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X              = ScreenSize.SCREEN_HEIGHT == 812.0
    static let IS_IPHONE_XMAX           = ScreenSize.SCREEN_HEIGHT == 896.0
    static let IS_PAD                   = UIDevice.current.userInterfaceIdiom == .pad
    static let IS_IPAD                  = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1024.0
    static let IS_IPAD_PRO              = UIDevice.current.userInterfaceIdiom == .pad && ScreenSize.SCREEN_MAX_LENGTH == 1366.0
    static let IsDeviceIPad             = IS_PAD || IS_IPAD || IS_IPAD_PRO ? true : false
}


// MARK: - iPhone Screensize
struct ScreenSize {
    static let SCREEN_WIDTH             = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT            = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH        = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH        = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}


///`AppColor`
extension Color {
    public static var AppThemeGrayColor: Color {
        return Color(uiColor: UIColor(named: "AppThemeGrayColor") ?? .red)
    }
    public static var AppBlack: Color {
        return Color(uiColor: UIColor(named: "AppBlack") ?? .red)
    }
    public static var AppWhite: Color {
        return Color(uiColor: UIColor(named: "AppWhiteBG") ?? .red)
    }
}
