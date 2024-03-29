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
                
                Toolbar
                NavigationLink {
                    CreateBudgetView(vm: budgetVM, isCreatingBudget: $isCreatingBudget)
                } label: {
                    Image(systemName: "plus.circle")
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isCreatingBudget.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
    
                    }
                }
            }
        }
//        .fullScreenCover(isPresented: $isCreatingBudget, content: {
//            CreateBudgetView(vm: budgetVM, isCreatingBudget: $isCreatingBudget)
//        })
        
        
    }
}

struct BudgetsView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetsView(budgetVM: dev.budgetVM)
    }
}
