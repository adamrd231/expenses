//
//  Extensions+Fonts.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import Foundation
import SwiftUI

///`UIFont`
extension UIFont {
    static let alertTitle = UIFont(name: "HelveticaNeue-Medium", size: 17)
    static let alertMessage = UIFont(name: "HelveticaNeue", size: 13)
    static let alertTitleiPad = UIFont(name: "HelveticaNeue-Medium", size: 22)
    static let alertMessageiPad = UIFont(name: "HelveticaNeue", size: 18)
    static let regularTitle = UIFont(name: "HelveticaNeue", size: 17)
    static let regularTitleiPad = UIFont(name: "HelveticaNeue", size: 22)
    static let navigationBarTitle = UIFont(name: "HelveticaNeue-Light", size: 21)
    static let navigationBarTitleiPad = UIFont(name: "HelveticaNeue-Light", size: 26)
}

///`FontStyle`
enum FontStyle: String {
    case HRegular                                = "Helvetica-Regular"
    case HMedium                                 = "HelveticaNeue-Medium"
    
}

///`SetFont`
extension Font {
    static func setFont(style: FontStyle = .HRegular, size: CGFloat = Constant.FontSize._16FontSize) -> Font {
        return .custom(style.rawValue, size: size)
    }
}

///`SetFont Function`
extension View {
    func setFont(style: FontStyle = .HRegular, size: CGFloat = Constant.FontSize._16FontSize) -> some View {
        self
            .font(.setFont(style: style, size: size))
    }
}

