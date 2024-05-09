import Foundation
import Combine

struct BudgetItem: Codable, Hashable {
    var id = UUID()
    var type: BudgetItemType
    var date: Date?
    var amount: Double
    
    init(name: BudgetItemType, due: Date? = nil, amount: Double) {
        self.type = name
        self.date = due
        self.amount = amount
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(type)
        hasher.combine(date)
        hasher.combine(amount)
    }
}






