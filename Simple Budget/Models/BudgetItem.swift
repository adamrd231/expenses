import Foundation
import Combine

struct BudgetItem: Codable, Hashable {
    var id = UUID()
    var name: BudgetName
    var due: Date?
    var amount: Double
    
    init(name: BudgetName, due: Date? = nil, amount: Double) {
        self.name = name
        self.due = due
        self.amount = amount
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(due)
        hasher.combine(amount)
    }
}

struct BudgetName: Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    static func == (lhs: BudgetName, rhs: BudgetName) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
