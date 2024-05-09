import Foundation

struct BudgetItems: Codable, Hashable, Identifiable {
    var id = UUID()
    let budgetCategory: BudgetCategory
    var budgetPercentage: Double
    var items: [BudgetItem] = []
    
    var totalSpend: Double {
        return items.map({ $0.amount }).reduce(0, +)
    }
}
