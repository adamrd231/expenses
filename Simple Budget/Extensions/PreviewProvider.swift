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
        
        transactionVM.transactions = []
        budgetVM.budgets = []
        budget.incomeItems = []
        budget.needItems = []
        budget.saveItems = []
        
        let newTransaction = Transaction(data: Date(), amount: 1200, category: .income, type: BudgetName(name: "Work"), name: "Yard work", description: "For lawncare and lanscaping")
        let secondTransaction = Transaction(data: Date(), amount: 910, category: .income, type: BudgetName(name: "Other Work"), name: "Yard work", description: "For lawncare and lanscaping")
        
        transactionVM.transactions.append(newTransaction)
        transactionVM.transactions.append(secondTransaction)
        

        
        var budget = Budget(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(100_000),
            startBalance: 0,
            needsBudgetPercentage: 0.5,
            wantsBudgetPercentage: 0.3,
            saveBudgetPercentage: 0.2,
            budgetItems: [
                BudgetItems(budgetCategory: .income, items: [BudgetItem(name: BudgetName(name: "Test"), amount: 200)]),
                BudgetItems(budgetCategory: .needs,items: [BudgetItem(name: BudgetName(name: "Test"), amount: 100)]),
                BudgetItems(budgetCategory: .wants,items: [BudgetItem(name: BudgetName(name: "Test"), amount: 50)]),
                BudgetItems(budgetCategory: .save,items: [BudgetItem(name: BudgetName(name: "Test"), amount: 25)])
            ],
            incomeItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 10000)],
            needItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 4000)],
            wantItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 2000)],
            saveItems: [BudgetItem(name: BudgetName(name: "Something"), amount: 1000)]
        )
        
        budget.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 10000))
        budget.needItems.append(BudgetItem(name: BudgetName(name:"Needs"), amount: 400))
        budget.wantItems.append(BudgetItem(name: BudgetName(name:"Wants"), amount: 150))
        budget.saveItems.append(BudgetItem(name: BudgetName(name:"Save"), amount: 100))
        
        budgetVM.budgets.append(budget)
        budgetVM.budgetModel = budget
        budgetVM.budgetModel.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 1000))
        budgetVM.budgetModel.needItems.append(BudgetItem(name:  BudgetName(name: "TV"), amount: 1000))
        budgetVM.budgetModel.wantItems.append(BudgetItem(name:  BudgetName(name: "Books"), amount: 300))
        budgetVM.budgetModel.saveItems.append(BudgetItem(name:  BudgetName(name: "Leaves"), amount: 500))
    }
    
}
