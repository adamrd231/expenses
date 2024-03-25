//
//  Date+Ext.swift
//  Simple Budget
//
//  Created by Eric Solberg on 3/1/24.
//

import Foundation

extension Date {
    
    /// Returns the Date as a String, in the form 1 Jan 2024
    func asString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        return formatter.string(from: self)
    }
}
