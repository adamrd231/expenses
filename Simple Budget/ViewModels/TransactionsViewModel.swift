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
            .combineLatest($categorySelection)
            .sink { [weak self] (returnedTransactions, returnedCategory) in
                var IllBeBack:[TransactionEntity] = []
                if returnedCategory != "All" {
                    let categoryName = BudgetCategory.allCases.first(where: { $0.rawValue == returnedCategory })
                    if let unwrappedCategoryName = categoryName {
                        let filteredTransactions = returnedTransactions.filter({ $0.category == unwrappedCategoryName.description })
                        IllBeBack = filteredTransactions
                    } else {
                        IllBeBack = returnedTransactions
                    }
                } else {
                    IllBeBack = returnedTransactions
                }
                
                self?.transactions = IllBeBack
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
