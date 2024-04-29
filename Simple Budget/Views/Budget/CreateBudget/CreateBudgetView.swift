import SwiftUI

struct CreateBudgetView: View {
    @ObservedObject var vm: BudgetsViewModel
    @State var newBudget: Budget = Budget()
    @State var currentIndex: Int? = 0
    @Environment(\.dismiss) var dismiss
  
    var body: some View {
        List {
            Section("Dates") {
                DateRangeRow(title: "Starting", date: $newBudget.start)
                DateRangeRow(title: "Ending", date: $newBudget.end)
            }
            
            Section("Add income") {
                NavigationLink {
                    BudgetSetupComponentView(
                        items: $newBudget.incomeItems,
                        budgetType: .income,
                        totalBudgetGoal: 0,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                } label: {
                    HStack {
                        Text("Income")
                        Spacer()
                        Text(newBudget.totalBudget, format: .currency(code: "USD"))
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
                    // TODO: Create budget hereg
                }
            }
        }
    }
}

struct CreateBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateBudgetView(
                vm: dev.budgetVM
            )
            .navigationTitle("Setup")
        }
    }
}
