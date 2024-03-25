//
//  Extensions+Number.swift
//  SimpleBudget
//
//  Created by Jaymeen Unadkat on 17/03/24.
//

import Foundation

extension Double {
    var twoDecimalString: String {
        String(format: "%.2f", self)
    }
}

extension Double {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 2
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
