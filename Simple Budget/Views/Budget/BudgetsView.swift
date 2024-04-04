import SwiftUI

struct BudgetsView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @State var isCreatingBudget: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(budgetVM.budgets, id: \.id) { budget in
                    HStack {
                        Text(budget.start, style: .date)
                        Text("-")
                        Text(budget.end, style: .date)
                    }
                }
                .onDelete(perform: { indexSet in
                    budgetVM.budgets.remove(atOffsets: indexSet)
                })
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
