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
    var transaction = Transaction(data: Date(), amount: 1200, category: .income, type: BudgetName(name: "Work"), name: "Yard work", description: "For lawncare and lanscaping")
    
    init() {
        
        let newTransaction = Transaction(data: Date(), amount: 1200, category: .income, type: BudgetName(name: "Work"), name: "Yard work", description: "For lawncare and lanscaping")
        
        transactionVM.transactions.append(newTransaction)
        
        budgetVM.budgets = []
        
        var budget = Budget(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(100_000),
            startBalance: 0,
            needsBudgetPercentage: 0.5,
            wantsBudgetPercentage: 0.3,
            saveBudgetPercentage: 0.2,
            incomeItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 10000)],
            needItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 10000)],
            wantItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 10000)],
            saveItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 10000)]
        )
        
        budget.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 10000))
        budget.needItems.append(BudgetItem(name: BudgetName(name:"Needs"), amount: 1000))
        budget.wantItems.append(BudgetItem(name: BudgetName(name:"Wants"), amount: 1000))
        budget.saveItems.append(BudgetItem(name: BudgetName(name:"Save"), amount: 1000))
        
        budgetVM.budgets.append(budget)
        budgetVM.budgetModel = budget
        budgetVM.budgetModel.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 10000))
        budgetVM.budgetModel.needItems.append(BudgetItem(name:  BudgetName(name: "TV"), amount: 1000))
        budgetVM.budgetModel.wantItems.append(BudgetItem(name:  BudgetName(name: "Books"), amount: 300))
        budgetVM.budgetModel.saveItems.append(BudgetItem(name:  BudgetName(name: "Leaves"), amount: 500))
    }
    
}
