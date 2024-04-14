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
    
    init() {
        budgetVM.budgets = []
        
        var budget = Budget(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(10000),
            startBalance: 0,
            needsBudgetPercentage: 0.5,
            wantsBudgetPercentage: 0.3,
            saveBudgetPercentage: 0.2,
            incomeItems: [],
            needItems: [],
            wantItems: [],
            saveItems: []
        )
        
        budget.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 10000))
        
        budgetVM.budgets.append(budget)
        budgetVM.budgetModel = budget
        budgetVM.budgetModel.incomeItems.append(BudgetItem(name: BudgetName(name: "Something"), amount: 10000))
        budgetVM.budgetModel.needItems.append(BudgetItem(name:  BudgetName(name: "TV"), amount: 1000))
        budgetVM.budgetModel.wantItems.append(BudgetItem(name:  BudgetName(name: "Books"), amount: 300))
        budgetVM.budgetModel.saveItems.append(BudgetItem(name:  BudgetName(name: "Leaves"), amount: 500))
    }
    
}
