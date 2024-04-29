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
            
            Section("Percentages") {
                HStack {
                    Text("Total")
                    Spacer()
                    Text(newBudget.budgetItems.map({ $0.budgetPercentage}).reduce(0, +),
                         format: .percent.precision(.fractionLength(0))
                    )
                }
                .font(.title3)
                .bold()
                ForEach($newBudget.budgetItems, id: \.self) { $budgetItem in
                    SliderView(value: $budgetItem.budgetPercentage, type: budgetItem.budgetCategory)
                }
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
            
            Section("Budget Items") {
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
                        VStack(alignment: .leading) {
                            Text(budgetItem.budgetCategory.description)
                            HStack {
                                Text("Goal")
                                Spacer()
                                Text(newBudget.totalBudget * budgetItem.budgetPercentage, format: .currency(code: "USD"))
                            }
                            .font(.caption)
                            HStack {
                                Text("Allocated")
                                Spacer()
                                Text(budgetItem.totalSpend, format: .currency(code: "USD"))
                            }
                            .font(.caption)
                        }
                    }
                }
            }
            
            Section("Overview") {
                BudgetActivityView(budget: newBudget)
                    .id(5)
                    .tag(5)
                    .containerRelativeFrame(.horizontal)
            }
        }
        .navigationTitle("Setup")
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
