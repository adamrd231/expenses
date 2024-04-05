//
//  Budget.swift
//  Simple Budget
//
//  Created by Eric Solberg on 2/29/24.
//

import Foundation

/**
 `Budget` datamodel
 */
struct Budget: Codable, Hashable {
    var id = UUID()
    var start: Date = .now
    var end: Date = .now.addingTimeInterval(60 * 60 * 24 * 30)
    var currencySymbol: String = "$"
    var startBalance: Double = 0.0
    
    // Budget Percentages for setting up app progress
    var needsBudgetPercentage: Double = 0.50
    var wantsBudgetPercentage: Double = 0.30
    var saveBudgetPercentage: Double = 0.20
    
    var totalBudgetPercentage: Double {
        return needsBudgetPercentage + wantsBudgetPercentage + saveBudgetPercentage
    }

    // Storage inside budget to add BudgetItems to each category
    var incomeItems: [BudgetItem] = []
    var needItems: [BudgetItem] = []
    var wantItems: [BudgetItem] = []
    var saveItems: [BudgetItem] = []
    
    // Computed variables for showing in UI
    var totalBudget: Double {
        return incomeItems.map({ $0.amount }).reduce(0, +)
    }
    
    var needBudgetTotal: Double {
        return needItems.map({ $0.amount }).reduce(0, +)
    }

    var needBudgetGoal: Double {
        return totalBudget * needsBudgetPercentage
    }
    
    var wantsBudgetTotal: Double {
        return wantItems.map({ $0.amount }).reduce(0, +)
    }
    
    var wantsBudgeGoal: Double {
        return totalBudget * wantsBudgetPercentage
    }
    
    var saveBudgetTotal: Double {
        return saveItems.map({ $0.amount }).reduce(0, +)
    }
    
    var saveBudgetGoal: Double {
        return totalBudget * saveBudgetPercentage
    }

}


/**
SwiftUI recommends using the struct over class
 */
