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
            .combineLatest($categorySelection, $searchText)
            .sink { [weak self] (returnedTransactions, returnedCategory, returnedSearchText) in
                var updatedTransactions:[TransactionEntity] = returnedTransactions
                
                // If no search text entered, no category selected, just return transactions
                guard returnedCategory != "All" else {
                    self?.transactions = updatedTransactions
                    return
                }
                
                // MARK: Category filtering
                if let categoryName = BudgetCategory.allCases.first(where: { $0.rawValue == returnedCategory }) {
                    let filteredTransactions = updatedTransactions.filter({ $0.category == categoryName.description })
                    updatedTransactions = filteredTransactions
                }
                
                // Update transactions on view with filtered
                self?.transactions = updatedTransactions
            }
            .store(in: &cancellable)
    }
    
    func addNew(_ transaction: Transaction) {
        dataManager.addNew(transaction)
    }
    
    func delete(_ transaction: TransactionEntity) {
        dataManager.deleteSingle(transaction)
    }
    
    func getActualTotalFromTransactions(type: BudgetCategory) -> Double {
        let t = transactions.filter({ $0.category == type.description })
        return t.map({ $0.amount }).reduce(0, +)
        
    }
}
