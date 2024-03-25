//
//  String+Ext.swift
//  Simple Budget
//
//  Created by Eric Solberg on 3/10/24.
//

import Foundation

extension String {
    
    /// Returns a String like` "$5.256"` as a Double like `5.26`.
    func asCurrency() -> Double {
        let amountWithoutCurrencySymbol = self.dropFirst()
        let amount = Double.init(amountWithoutCurrencySymbol) ?? 0.0
        let rounded = (amount * 100).rounded() / 100
        return rounded
    }
}
