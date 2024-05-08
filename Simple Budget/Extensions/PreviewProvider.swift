import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

struct DeveloperPreview {
    static let instance = DeveloperPreview()
    var budgetVM = BudgetsViewModel()
    var budget = Budget()
    var transactionVM = TransactionsViewModel()
    var transaction = Transaction(data: Date(), amount: 1200, category: .income, type: BudgetName(name: "Work"), description: "For lawncare and lanscaping")
    
    init() {
        
        transactionVM.transactions = []
        budgetVM.budgets = []
        budget.incomeItems = []

        
        let newTransaction = Transaction(data: Date(), amount: 1200, category: .income, type: BudgetName(name: "Work"), description: "For lawncare and lanscaping")
        let secondTransaction = Transaction(data: Date(), amount: 910, category: .income, type: BudgetName(name: "Other Work"), description: "For lawncare and lanscaping")
        
        transactionVM.transactions.append(newTransaction)
        transactionVM.transactions.append(secondTransaction)
        
        var budget = Budget(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(100000),
            startBalance: 0,
            incomeItems: [BudgetItem(name: BudgetName(name: "Income"), amount: 10000)],
            budgetItems: [
                BudgetItems(budgetCategory: .needs, budgetPercentage: 0.5),
                BudgetItems(budgetCategory: .wants, budgetPercentage: 0.3),
                BudgetItems(budgetCategory: .save, budgetPercentage: 0.2)
            ]
        )
        budgetVM.budgetModel = budget
        budgetVM.budgets.append(budget)
    }
}
