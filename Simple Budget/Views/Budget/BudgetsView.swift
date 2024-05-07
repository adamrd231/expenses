import SwiftUI

struct BudgetsView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @State var isCreatingBudget: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgetVM.budgets, id: \.id) { budget in
                    NavigationLink {
                        CreateBudgetView(
                            budget: budget,
                            function: { [weak budgetVM] budget in
                                if let budgetIndex = budgetVM?.budgets.firstIndex(where: { $0.id == budget.id }) {
                                    budgetVM?.budgets.remove(at: budgetIndex)
                                    budgetVM?.budgets.append(budget)
                                }
                            },
                            isNewBudget: false
                        )
                    } label: {
                        BudgetRowView(budget: budget)
                    }
                }
                .onDelete(perform: { indexSet in
                    budgetVM.budgets.remove(atOffsets: indexSet)
                })
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .navigationTitle("Budgets")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreatingBudget.toggle()
                    } label: {
                        NavigationLink {
                            CreateBudgetView(
                                function: { [weak budgetVM] budget in
                                    budgetVM?.budgets.append(budget)
                                },
                                isNewBudget: true
                            )
                        } label: {
                            Image(systemName: "plus.circle")
                        }
                    }
                }
            }
        }
    }
}

struct BudgetsView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetsView(budgetVM: dev.budgetVM)
    }
}
