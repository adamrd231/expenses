import Foundation

struct Budget: Codable {
    static func == (lhs: Budget, rhs: Budget) -> Bool {
        lhs.start < rhs.start
    }
    var id = UUID()
    var start: Date = .now
    var end: Date = .now.addingTimeInterval(60 * 60 * 24 * 30)
    var startBalance: Double = 0.0
    var incomeItems: [BudgetItem] = []
    var totalIncome: Double {
        return incomeItems.map({ $0.amount }).reduce(0, +)
    }

    var budgetItems: [BudgetItems] = [
        BudgetItems(
            budgetCategory: .needs,
            budgetPercentage: 0.5,
            items: []
        ),
        BudgetItems(
            budgetCategory: .wants,
            budgetPercentage: 0.3,
            items: []
        ),
        BudgetItems(
            budgetCategory: .save,
            budgetPercentage: 0.2,
            items: []
        )
    ]
    
}

struct BudgetItems: Codable, Hashable, Identifiable {
    var id = UUID()
    let budgetCategory: BudgetCategory
    var budgetPercentage: Double
    var items: [BudgetItem] = []
    
    var totalSpend: Double {
        return items.map({ $0.amount }).reduce(0, +)
    }
}

