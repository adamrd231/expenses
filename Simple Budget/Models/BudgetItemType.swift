import Foundation

struct BudgetItemType: Codable, Equatable, Hashable {
    var id = UUID()
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
    static func == (lhs: BudgetItemType, rhs: BudgetItemType) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}
