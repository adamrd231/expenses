import Foundation

enum BudgetCategory: String, Equatable, CaseIterable, Codable {
    case income = "Income"
    case needs = "Needs"
    case wants = "Wants"
    case save = "Save"
    
    var description: String {
        switch self {
        case .income: return "Income"
        case .needs: return "Needs"
        case .wants: return "Wants"
        case .save: return "Save"
        }
    }
}
