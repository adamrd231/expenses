import SwiftUI

struct CreateBudgetView: View {
    @ObservedObject var vm: BudgetsViewModel
    @State var newBudget: Budget = Budget()
    @State var currentIndex: Int? = 0
    @Environment(\.dismiss) var dismiss
  
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(alignment: .top, spacing: 0) {
                    SetupView(budget: $newBudget)
                        .id(0)
                        .tag(0)
                        .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(
                        items: $newBudget.incomeItems,
                        budgetType: .income,
                        totalBudgetGoal: newBudget.totalBudget,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                    .id(1)
                    .tag(1)
                    .containerRelativeFrame(.horizontal)

                    BudgetSetupComponentView(
                        items: $newBudget.needItems,
                        budgetType: .needs,
                        totalBudgetGoal: newBudget.needBudgetGoal,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                    .id(2)
                    .tag(2)
                    .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(
                        items: $newBudget.wantItems,
                        budgetType: .wants,
                        totalBudgetGoal: newBudget.wantsBudgeGoal,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                    .id(3)
                    .tag(3)
                    .containerRelativeFrame(.horizontal)
                    
                    BudgetSetupComponentView(
                        items: $newBudget.saveItems,
                        budgetType: .save,
                        totalBudgetGoal: newBudget.saveBudgetGoal,
                        startDate: newBudget.start,
                        endDate: newBudget.end
                    )
                        .id(4)
                        .tag(4)
                        .containerRelativeFrame(.horizontal)
                    BudgetActivityView(budget: newBudget)
                        .id(5)
                        .tag(5)
                        .containerRelativeFrame(.horizontal)
                }
                .scrollTargetLayout()
               
            }
            .scrollPosition(id: $currentIndex)
            .scrollIndicators(.visible)
        }
        .scrollTargetBehavior(.paging)
        .navigationTitle("Setup (\(((currentIndex ?? 0) + 1).description) of 6)")
        .toolbarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if currentIndex != 5 {
                    Button("Next") {
                        if let index = currentIndex {
                            currentIndex = index + 1
                        }
                        
                    }
                } else {
                    Button("Create") {
                        vm.budgets.append(newBudget)
                        dismiss()
                    }
                }
            }
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    } label: {
                        Text("Done")
                    }
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
            .navigationTitle("Something")
        }
    }
}
