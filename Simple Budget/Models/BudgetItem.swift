//
//  BudgetItem.swift
//  Simple Budget
//
//  Created by Eric Solberg on 3/1/24.
//

import Foundation

struct BudgetItem: Codable, Hashable {
    var id = UUID()
    var name: String
    var due: Date?
    var amount: Double
    
    init(name: String, due: Date? = nil, amount: Double) {
        self.name = name
        self.due = due
        self.amount = amount
    }
}
