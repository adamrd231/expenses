import Foundation

enum BudgetCategory: String, Equatable, CaseIterable, Codable {
    case income = "income"
    case needs = "needs"
    case wants = "wants"
    case save = "save"
    
    var description: String {
        switch self {
        case .income: return "Income"
        case .needs: return "Needs"
        case .wants: return "Wants"
        case .save: return "Save"
        }
    }
}
