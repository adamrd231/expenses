import Foundation
import Combine

class TransactionsViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var newTransaction: Transaction? = nil
    @Published private var cancellable = Set<AnyCancellable>()
    @Published var searchText: String = ""
    @Published var categoryPickerSelection: BudgetCategory = .income
    @Published var categorySelection: String = "All"
    
    var filteredTransactions: [Transaction] {
        if searchText.isEmpty {
            if categorySelection == "All" {
                return transactions.sorted(by: { $0.date > $1.date })
            } else {
                let categoryName = BudgetCategory.allCases.first(where: { $0.rawValue == categorySelection })
                if let unwrappedCategoryName = categoryName {
                    let categories = transactions.filter({ $0.category == unwrappedCategoryName })
                    return categories.sorted(by: { $0.date > $1.date })
                } else {
                    return transactions.sorted(by: { $0.date > $1.date })
                }
            }
        } else {
            let searchTextFilteredTransactions =  transactions.filter({ $0.category.description.contains(searchText ) })
            if categorySelection == "All" {
                return searchTextFilteredTransactions.sorted(by: { $0.date > $1.date })
            } else {
                return searchTextFilteredTransactions.filter({ $0.category == categoryPickerSelection }).sorted(by: { $0.date > $1.date })
            }
        }
    }
    
    init() {
        retrieveTransactions()
        addSubscribers()
    }
    
    func addSubscribers() {
        $transactions
            .sink { [weak self] (returnedTransactions) in
                self?.persist(transactionArray: returnedTransactions)
            }
            .store(in: &cancellable)
    }
    
    func addNew(transaction: Transaction) {
        transactions.append(transaction)
    }
    
    func persist(transactionArray: [Transaction]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(transactionArray) {
            UserDefaults.standard.set(encoded, forKey: "transactions")
        } else {
            print("Error persisting user budgets")
        }
    }
    
    func retrieveTransactions() {
        if let transactionData = UserDefaults.standard.value(forKey: "transactions") as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Transaction].self, from: transactionData) {
               transactions = decoded
            } else {
                print("Error retrieving budgets: decoding budgets")
            }
        } else {
            print("Error retrieving budgets: no budget data")
        }
    }
    
    func getActualTotalFromTransactions(type: BudgetCategory) -> Double {
        // filter out any budgets not within date range
        let today = Date()
        let t = transactions.filter({ $0.category == type })
        return t.map({ $0.amount }).reduce(0, +)
        
    }
}
