import SwiftUI

struct CreateBudgetView: View {
    var function: (Budget) -> Void
    @State var newBudget: Budget
    let isNewBudget: Bool
    let compareBudget: Budget
    @State var showingAlert = false
    
    @Environment(\.dismiss) var dismiss
    
    init(budget: Budget? = nil, function: @escaping (Budget) -> Void, isNewBudget: Bool) {
        self._newBudget = State(initialValue: budget ?? Budget())
        self.function = function
        self.isNewBudget = isNewBudget
        self.compareBudget = budget ?? Budget()
    }
    
    var hasChanged: Bool {
        if compareBudget == newBudget {
            return false
        } else {
            return true
        }
    }
  
    var body: some View {
        Form {
            Section("Info") {
                TextField("Budget Name", text: $newBudget.name)
            }
            Section("Dates") {
                HStack {
                    Text("Start Date")
                    DatePicker("", selection: $newBudget.start, displayedComponents: [.date])
                }
                HStack {
                    Text("End Date")
                    DatePicker("", selection: $newBudget.end, displayedComponents: [.date])
                }
            }
            
            Section("Add income") {
                HStack {
                    Image(systemName: newBudget.incomeItems.isEmpty ? "checkmark.circle.trianglebadge.exclamationmark" : "checkmark.circle.fill")
                        .foregroundStyle(newBudget.incomeItems.isEmpty ? Color.theme.red : Color.theme.green)
                    Text("Income")
                    Spacer()
                    Text(newBudget.totalIncome, format: .currency(code: "USD"))
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
                    HStack {
                        Text(budgetItem.budgetCategory.description)
                            .font(.callout)
                            .bold()
                        Divider()
                        SliderView(value: $budgetItem.budgetPercentage, type: budgetItem.budgetCategory)
                        
                    }
                }
            }
            
            
            ForEach($newBudget.budgetItems, id: \.id) { $budgetItem in
                Section("\(budgetItem.budgetCategory.description) Items") {
                    ProgressBarView(
                        currentSpend: budgetItem.totalSpend,
                        totalBudget: budgetItem.budgetPercentage * newBudget.totalIncome
                    )
                    
                    NavigationLink {
                        BudgetSetupComponentView(
                            items: $budgetItem.items,
                            budgetType: budgetItem.budgetCategory,
                            totalBudgetGoal: newBudget.totalIncome * budgetItem.budgetPercentage,
                            startDate: newBudget.start,
                            endDate: newBudget.end
                        )
                    } label: {
                        HStack {
                            Image(systemName: budgetItem.items.isEmpty ? "checkmark.circle.trianglebadge.exclamationmark" : "checkmark.circle.fill")
                                .foregroundStyle(budgetItem.items.isEmpty ? Color.theme.red : Color.theme.green)
                            VStack(alignment: .leading) {
                                Text(budgetItem.items.isEmpty ? "Add items" : "Add Items: \(budgetItem.items.count)")
                                    .font(.caption)
                            }
                        }
                       
                    }
                    
                    ForEach(Array(zip(budgetItem.items, budgetItem.items.indices)), id: \.1) { item, index in
                        HStack {
                            Text(index + 1, format: .number)
                            Text(item.type.name)
                            Spacer()
                            Text(item.amount, format: .currency(code: "USD"))
                        }
                        .font(.caption)
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Are you sure?"),
                    message: Text("Your information will not be saved?"),
                    primaryButton: .default(Text("Continue"), action: {
                      dismiss()
                    }),
                    secondaryButton: .cancel()
                )
            }
        }
        .navigationTitle(isNewBudget ? "Setup Budget" : "Edit Budget")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(isNewBudget ? "Create" : "Save") {
                    function(newBudget)
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Back") {
                    if hasChanged {
                        showingAlert = true
                    } else {
                        dismiss()
                    }
                }
               
            }
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct CreateBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CreateBudgetView(
                function: { _ in },
                isNewBudget: true
            )
            .navigationTitle("Setup")
        }
    }
}
