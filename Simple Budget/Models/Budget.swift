import Foundation

struct Budget: Codable {
    static func == (lhs: Budget, rhs: Budget) -> Bool {
        lhs.start < rhs.start
    }
    
    var id = UUID()
    var start: Date = .now
    var end: Date = .now.addingTimeInterval(60 * 60 * 24 * 30)

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
    
    var budgets: [Budgets] = [
        Budgets(budgetCategory: .income, items: []),
        Budgets(budgetCategory: .needs, items: []),
        Budgets(budgetCategory: .wants, items: []),
        Budgets(budgetCategory: .save, items: [])
    ]
    
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

struct Budgets: Codable {
    var budgetCategory: BudgetCategory
    var items: [BudgetItem]
}

