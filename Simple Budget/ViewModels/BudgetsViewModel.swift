import Foundation
import Combine

class BudgetsViewModel: ObservableObject {
    @Published var budgets: [Budget] = []
    @Published var budgetModel: Budget = Budget()
    @Published private var cancellable = Set<AnyCancellable>()
    @Published var budgetCategoryTypes: [TransactionCategory] = []
    // Load persisted budgets when view model is created
    // Subscribe to budgets, and manage persistence any time the array changes
    
    // TODO: OMG Rename this, this and budgetCategories are too similar and this name sucks
    var budgetNames: [BudgetName] {
        return []
    }
    
    init() {
        retrieveBudgets()
        addSubscribers()
    }
     
    func addSubscribers() {
        $budgets
            .sink { [weak self] (returnedBudgets) in
                print("Budgets changed \(returnedBudgets)")
                self?.persist(budgetArray: returnedBudgets)
                
            }
            .store(in: &cancellable)
    }
    
    func persist(budgetArray: [Budget]) {
       
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(budgetArray) {
            UserDefaults.standard.set(encoded, forKey: "user_budgets")
        } else {
            print("Error persisting user budgets")
        }
    }
    
    func retrieveBudgets() {
       
        if let budgetsData = UserDefaults.standard.value(forKey: "user_budgets") as? Data {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Budget].self, from: budgetsData) {
               budgets = decoded
            } else {
                print("Error retrieving budgets: decoding budgets")
            }
        } else {
            print("Error retrieving budgets: no budget data")
        }
    }
    
    func addBudgetItemToBudgetArray() {
        budgets.append(budgetModel)
    }
    
    func getExpectedTotalFromBudgets(type: BudgetCategory) -> Double {

        return 0
    }
}

