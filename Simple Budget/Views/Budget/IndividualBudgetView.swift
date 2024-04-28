import SwiftUI

struct IndividualBudgetView: View {
    @State var budget: Budget
    var body: some View {
        List {
            Section("Budget planning") {
                HStack {
                    Spacer()
                    BudgetActivityView(budget: budget)
                    Spacer()
                }
            }
            
            Section("Budget Breakdown") {
                HStack {
                    Text("Total Income")
                    Spacer()
                    HStack {
                        VStack {
                            Text("Goal")
                            Text(budget.totalBudget, format: .currency(code: "USD"))
                        }
                    }
                    .font(.caption)
                }
                
                ForEach(budget.budgetItems, id: \.id) { budgetItem in
                    Text(budgetItem.budgetCategory.description)
                }
                
                Grid {
                    BudgetOverviewRowView(
                        type: .needs,
                        budgetGoal: budget.needBudgetGoal,
                        budgetItemTotal: budget.needItems.map({ $0.amount }).reduce(0, +)
                    )
                }
                Grid {
                    BudgetOverviewRowView(
                        type: .save,
                        budgetGoal: budget.saveBudgetGoal,
                        budgetItemTotal: budget.saveItems.map({ $0.amount }).reduce(0, +)
                    )
                }
            }
        }
    }
}


struct IndividualBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBudgetView(budget: dev.budgetVM.budgetModel)
    }
}
