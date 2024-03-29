import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

struct DeveloperPreview {
    static let instance = DeveloperPreview()
    var budgetVM = BudgetsViewModel()
    
    init() {
        budgetVM.budgets = []
        let budget = Budget(
            id: UUID(),
            start: Date(),
            end: Date().addingTimeInterval(10000),
            currencySymbol: "$",
            startBalance: 0,
            needsBudgetPercentage: 0.5,
            wantsBudgetPercentage: 0.3,
            saveBudgetPercentage: 0.2,
            incomeItems: [],
            needItems: [],
            wantItems: [],
            saveItems: [])
        budgetVM.budgets.append(budget)
    }
}
