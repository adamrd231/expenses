import Foundation

struct Transaction: Codable {
    let id = UUID()
    var date: Date
    var amount: Double
    var category: BudgetCategory
    var type: TransactionCategory
    var name: String
    var description: String
    
    init(data: Date, amount: Double, category: BudgetCategory, type: TransactionCategory, name: String, description: String) {
        self.date = data
        self.amount = amount
        self.category = category
        self.type = type
        self.name = name
        self.description = description
    }
}

struct TransactionCategory: Codable, Hashable {
    var id = UUID()
    var name: String
}
