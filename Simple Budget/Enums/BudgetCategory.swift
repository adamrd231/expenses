import Foundation

enum BudgetCategory: String, Equatable, CaseIterable, Codable {
    case all = "all"
    case income = "income"
    case needs = "needs"
    case wants = "wants"
    case save = "save"
    
    var description: String {
        switch self {
        case .all: return "All"
        case .income: return "Income"
        case .needs: return "Needs"
        case .wants: return "Wants"
        case .save: return "Save"
        }
    }
}
