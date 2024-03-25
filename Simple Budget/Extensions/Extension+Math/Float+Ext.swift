//
//  Float+Ext.swift
//  Simple Budget
//
//  Created by Eric Solberg on 2/29/24.
//

import Foundation

extension Float {
    
    /// Returns the Float as a rounded percent.
    ///
    /// Example: 0.251 returns "25%"
    func asPercent() -> String {
        let asPercent = self * 100
        let rounded = asPercent.rounded()
        let asInt = Int(rounded)
        let asString = "\(asInt)%"
        return asString
    }
    
    /// Rounds the Float to two decimal places.
    ///
    /// Example: 0.251 returns 0.25
    func roundToTwoDecimals() -> Float {
        return (self * 100).rounded() / 100
    }
}
