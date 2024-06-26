import Foundation
import Combine

class BudgetsViewModel: ObservableObject {
    @Published var budgets: [Budget] = []
    @Published var budgetModel: Budget = Budget()
    @Published var budgetCategoryTypes: [TransactionCategory] = []
    @Published private var cancellable = Set<AnyCancellable>()
    
    init() {
        retrieveBudgets()
        addSubscribers()
    }
    
    func addSubscribers() {
        $budgets
            .sink { [weak self] (returnedBudgets) in
                self?.persist(budgetArray: returnedBudgets)
                
            }
            .store(in: &cancellable)
    }
    
    func getBudgetPercentageTotal() {
        
    }
    
    var budgetNames: [BudgetCategory: [BudgetItemType]] {
        var array:[BudgetCategory: [BudgetItemType]] = [
            .income: [],
            .needs: [],
            .save: [],
            .wants: []
            
        ]
        for budget in budgets {
            // Collect income items
            for budgetItem in budget.incomeItems {
                array[.income]?.append(budgetItem.type)
            }
            // These are the 50 / 30 / 20 budget items
            for budgetItem in budget.budgetItems {
                for item in budgetItem.items {
                    array[budgetItem.budgetCategory]?.append(item.type)
                }
            }
        }
        return array
    }
    
    func getBudgetItems(category: BudgetCategory) -> [BudgetItem] {
        var array: [BudgetItem] = []
        if category == .income {
            for budget in budgets {
                for item in budget.incomeItems {
                    array.append(item)
                }
                
            }
        } else {
            for budget in budgets {
                for budgetItem in budget.budgetItems {
                    if budgetItem.budgetCategory == category {
                        for item in budgetItem.items {
                            array.append(item)
                        }
                    }
                }
            }
        }
        return array
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
        if type == .income {
            let incomeItems = budgets.map({ $0.incomeItems.map({ $0.amount }).reduce(0, +) }).reduce(0, +)
            return incomeItems
        } else {
            var budgetItemArray:[Double] = []
            for budget in budgets {
                for budgetItem in budget.budgetItems {
                    if budgetItem.budgetCategory == type {
                        for item in budgetItem.items {
                            budgetItemArray.append(item.amount)
                        }
                    }
                }
            }
            return budgetItemArray.reduce(0, +)
        }
    }
}

