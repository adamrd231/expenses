import SwiftUI

struct BudgetsView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @State var isCreatingBudget: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgetVM.budgets, id: \.id) { budget in
//                    NavigationLink {
//                        Text("Destination")
//                    } label: {
                        BudgetRowView(budget: budget)
//                    }
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
                            CreateBudgetView(vm: budgetVM)
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
