//
//  BudgetItem.swift
//  Simple Budget
//
//  Created by Eric Solberg on 3/1/24.
//

import Foundation

struct BudgetItem: Codable, Hashable {
    var id = UUID()
    var type: BudgetCategory
    var name: String
    var due: Int?
    var amount: Double
    
    init(type: BudgetCategory, name: String, due: Int? = nil, amount: Double) {
        self.type = type
        self.name = name
        self.due = due
        self.amount = amount
    }
}
