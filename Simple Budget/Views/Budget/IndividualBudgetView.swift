import SwiftUI

struct IndividualBudgetView: View {
    @State var budget: Budget
    var body: some View {
        List {
            HStack {
                Spacer()
                BudgetActivityView(budget: budget)
                Spacer()
            }
           
            
            
            HStack {
                Text("Total Income")
                Spacer()
                HStack {
                    VStack {
                        Text("Goal")
                        Text(budget.totalBudget, format: .currency(code: "USD"))
                    }
                    VStack {
                        Text("Allocated")
                        Text(budget.needBudgetTotal + budget.wantsBudgetTotal + budget.saveBudgetTotal, format: .currency(code: "USD"))
                    }
                }
                .font(.caption)
            }
            HStack {
                Text("Needs")
                Text(budget.needsBudgetPercentage, format: .percent)
            }
            HStack {
                Text("Wants")
                Text(budget.wantsBudgetPercentage, format: .percent)
            }
            HStack {
                Text("Save")
                    .bold()
                Text(budget.saveBudgetPercentage, format: .percent)
                Spacer()
                HStack {
                    VStack {
                        Text("Goal")
                        Text(budget.saveBudgetGoal, format: .currency(code: "USD"))
                    }
                   
                    Text("|")
                    VStack {
                        Text("Allocated")
                        Text(budget.saveItems.map({ $0.amount }).reduce(0, +), format: .currency(code: "USD"))
                    }
                }
                .font(.caption)
            }
            
//            Text("Income Items")
//                .bold()
//            ForEach(budget.incomeItems, id: \.id) { incomeItem in
//                HStack {
//                    Text(incomeItem.name.name)
//                    Spacer()
//                    Text(incomeItem.amount, format: .currency(code: "USD"))
//                }
//            }
        }
    }
}


struct IndividualBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBudgetView(budget: dev.budgetVM.budgetModel)
    }
}
