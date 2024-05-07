import SwiftUI

struct CreateBudgetView: View {
    // This could be a function to either add new budget, or replace existing one
    @ObservedObject var vm: BudgetsViewModel
    var function: (Budget) -> Void
    
    // This needs to be able to accept a budget passed in, and if no budget is passed in, then create a new budget object
    @State var newBudget: Budget = Budget()
    @Environment(\.dismiss) var dismiss
  
    var body: some View {
        List {
            Section("Dates") {
                DateRangeRow(title: "Starting", date: $newBudget.start)
                DateRangeRow(title: "Ending", date: $newBudget.end)
            }
            
            Section("Add income") {
                HStack {
                    Image(systemName: newBudget.incomeItems.isEmpty ? "checkmark.circle.trianglebadge.exclamationmark" : "checkmark.circle.fill")
                        .foregroundStyle(newBudget.incomeItems.isEmpty ? Color.theme.red : Color.theme.green)
                    Text("Income")
                    Spacer()
                    Text(newBudget.totalBudget, format: .currency(code: "USD"))
                }
                NavigationLink {
                    BudgetSetupComponentView(
                        items: $newBudget.incomeItems,
                        budgetType: .income,
                        totalBudgetGoal: 0,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                } label: {
                    VStack(alignment: .leading) {
                        Text(newBudget.incomeItems.isEmpty ? "Add items" : "Items: \(newBudget.incomeItems.count)")
                            .font(.caption)
                    }
                   
                }
            }
            
            Section("50/30/20 Budgeting") {
                HStack {
                   Text("Budget Breakdown")
                        .bold()
                    Spacer()
                    Text(newBudget.budgetItems.map({ $0.budgetPercentage }).reduce(0, +), format: .percent.precision(.fractionLength(0)))
                        .foregroundStyle(newBudget.budgetItems.map({ $0.budgetPercentage }).reduce(0, +) > 1 ? Color.theme.red : Color.theme.text)
                    
                }
                HStack {
                    Text("Reset")
                    Spacer()
                    Button {
                        for index in newBudget.budgetItems.indices {
                            newBudget.budgetItems[index].budgetPercentage = 0.5
                            if index == 0 {
                                newBudget.budgetItems[index].budgetPercentage = 0.5
                            } else if index == 1 {
                                newBudget.budgetItems[index].budgetPercentage = 0.3
                            } else if index == 2 {
                                newBudget.budgetItems[index].budgetPercentage = 0.2
                            }
                        }
                    } label: {
                        Image(systemName: "arrow.uturn.left.circle.fill")
                    }
                }
                ForEach($newBudget.budgetItems, id: \.id) { $budgetItem in
                    NavigationLink {
                        BudgetSetupComponentView(
                            items: $budgetItem.items,
                            budgetType: budgetItem.budgetCategory,
                            totalBudgetGoal: newBudget.totalBudget * budgetItem.budgetPercentage,
                            startDate: newBudget.start,
                            endDate: newBudget.end
                        )
                    } label: {
                        VStack(alignment: .leading, spacing: 5) {
                       
                            HStack {
                                Text(budgetItem.budgetCategory.description)
                                    .font(.callout)
                                    .bold()
                                Divider()
                                SliderView(value: $budgetItem.budgetPercentage, type: budgetItem.budgetCategory)
                                
                            }
                            
                            HStack {
                                VStack {
                                    Text("GOAL")
                                        .bold()
                                        .foregroundStyle(Color.theme.secondaryText)
                                        .fontWeight(.bold)
                                        .font(.caption2)
                                    
                                    Text(newBudget.totalBudget * budgetItem.budgetPercentage, format: .currency(code: "USD"))
                                }
                                Spacer()
                                VStack {
                                    Text("ALLOCATED")
                                        .bold()
                                        .foregroundStyle(Color.theme.secondaryText)
                                        .fontWeight(.bold)
                                        .font(.caption2)
                                    Text(budgetItem.totalSpend, format: .currency(code: "USD"))
                                }
                                Spacer()
                                VStack {
                                   
                                    Text("AVAILABLE")
                                        .bold()
                                        .foregroundStyle(Color.theme.secondaryText)
                                        .fontWeight(.bold)
                                        .font(.caption2)
                                    Text((newBudget.totalBudget * budgetItem.budgetPercentage) - budgetItem.totalSpend, format: .currency(code: "USD"))
                                }
                            }
                            .font(.caption)
                        }
                        .padding(.bottom)
                    }
                }
            }
        }
        .navigationTitle("Setup")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Create") {
                    // TODO: Create budget here
//                    vm.budgets.append(newBudget)
                    function(newBudget)
                }
//                .disabled(true)
            }
        }
    }
}

struct CreateBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateBudgetView(
                vm: dev.budgetVM,
                function: { _ in }
            )
            .navigationTitle("Setup")
        }
    }
}
