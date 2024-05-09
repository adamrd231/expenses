import Foundation

struct Budget: Codable, Equatable {
    var id = UUID()
    var name: String = "New Budget"
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
    
    // Equatable function to help detect when user has changed something in the object
    public static func == (lhs: Budget, rhs: Budget) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.start == rhs.start &&
            lhs.end == rhs.end &&
            lhs.incomeItems == rhs.incomeItems &&
            lhs.budgetItems == rhs.budgetItems &&
            lhs.startBalance == rhs.startBalance
    }
}

