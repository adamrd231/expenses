import Foundation
import Combine

class TransactionsViewModel: ObservableObject {
    @Published var transactions: [TransactionEntity] = []
    @Published var newTransaction: Transaction? = nil
    let dataManager = DataManager()
    
    @Published private var cancellable = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var categoryPickerSelection: BudgetCategory = .income
    @Published var categorySelection: String = "All"
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        dataManager.$transactions
            .sink { [weak self] (returnedTransactions) in
                self?.transactions = returnedTransactions
            }
            .store(in: &cancellable)
    }
    
    func addNew(_ transaction: Transaction) {
        dataManager.addNew(transaction)
    }
    
    func delete(_ transaction: TransactionEntity) {
        dataManager.deleteSingle(transaction)
    }
    
//    var filteredTransactions: [Transaction] {
//        if searchText.isEmpty {
//            if categorySelection == "All" {
//                return transactions.sorted(by: { $0.date > $1.date })
//            } else {
//                let categoryName = BudgetCategory.allCases.first(where: { $0.rawValue == categorySelection })
//                if let unwrappedCategoryName = categoryName {
//                    let categories = transactions.filter({ $0.category == unwrappedCategoryName })
//                    return categories.sorted(by: { $0.date > $1.date })
//                } else {
//                    return transactions.sorted(by: { $0.date > $1.date })
//                }
//            }
//        } else {
//            let searchTextFilteredTransactions =  transactions.filter({ $0.category.description.contains(searchText ) })
//            if categorySelection == "All" {
//                return searchTextFilteredTransactions.sorted(by: { $0.date > $1.date })
//            } else {
//                return searchTextFilteredTransactions.filter({ $0.category == categoryPickerSelection }).sorted(by: { $0.date > $1.date })
//            }
//        }
//    }
//    
    func getActualTotalFromTransactions(type: BudgetCategory) -> Double {
        // filter out any budgets not within date range
        let today = Date()
        let t = transactions.filter({ $0.category == type.description })
        return t.map({ $0.amount }).reduce(0, +)
        
    }
}
