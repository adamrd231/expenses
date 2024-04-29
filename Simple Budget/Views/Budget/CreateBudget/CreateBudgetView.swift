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
