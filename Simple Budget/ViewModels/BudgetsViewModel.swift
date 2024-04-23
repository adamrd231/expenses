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
        var array:[BudgetName] = [BudgetName(name: "Other")]
        for budget in budgets {
            for incomeItem in budget.incomeItems {
                array.append(incomeItem.name)
            }
            for incomeItem in budget.needItems {
                array.append(incomeItem.name)
            }
            for incomeItem in budget.wantItems {
                array.append(incomeItem.name)
            }
        }
        return array
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
        // filter out any budgets not within date range
        let today = Date()
        let filteredByDate = budgets.filter({ $0.start <= today && $0.end >= today })
        switch type {
        case .income: return filteredByDate.map({ $0.incomeItems.map({ $0.amount }).reduce(0,+)}).reduce(0,+)
        case .needs:
            let budgetTotalAgainstPercentage = filteredByDate.map({ $0.incomeItems.map({ $0.amount }).reduce(0,+) * $0.needsBudgetPercentage }).reduce(0,+)
            return budgetTotalAgainstPercentage
//            filteredByDate.map({ $0.needItems.map(({ $0.amount }).reduce(0, +)) * $0.needsBudgetPercentage)})
        case .wants: return filteredByDate.map({ $0.wantItems.map({ $0.amount }).reduce(0,+)}).reduce(0,+)
        case .save: return filteredByDate.map({ $0.saveItems.map({ $0.amount }).reduce(0,+)}).reduce(0,+)
        }
        
    }
}

