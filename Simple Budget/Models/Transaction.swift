import Foundation

struct Transaction: Codable {
    let id = UUID()
    var date: Date
    var amount: Double
    var category: BudgetCategory
    var type: BudgetItemType
    var description: String
    
    init(data: Date, amount: Double, category: BudgetCategory, type: BudgetItemType, description: String) {
        self.date = data
        self.amount = amount
        self.category = category
        self.type = type
        self.description = description
    }
}

struct TransactionCategory: Codable, Hashable {
    var id = UUID()
    var name: String
}
