//
//  Double+Ext.swift
//  Simple Budget
//
//  Created by Eric Solberg on 3/1/24.
//

import Foundation

extension Double {
    
    /// Returns the Double as a currency String with the provided symbol.
    ///
    /// Example: 5.432 w/ the symbol "$" returns "$5.43.
    func asCurrency(symbol: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        let string = formatter.string(from: NSNumber(value: self)) ?? ""
        return symbol + string.dropFirst()
    }
}
