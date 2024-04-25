import SwiftUI

struct IndividualBudgetView: View {
    @State var budget: Budget
    var body: some View {
        List {
            HStack {
                Text("Total Income")
                Spacer()
                Text(budget.totalBudget, format: .currency(code: "USD"))
            }
            HStack {
                Text("Total Income")
                Spacer()
                Text(budget.totalBudget, format: .currency(code: "USD"))
            }
            
            Text("Income Items")
                .bold()
            ForEach(budget.incomeItems, id: \.id) { incomeItem in
                HStack {
                    Text(incomeItem.name.name)
                    Spacer()
                    Text(incomeItem.amount, format: .currency(code: "USD"))
                }
            }
        }
    }
}


struct IndividualBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        IndividualBudgetView(budget: dev.budgetVM.budgetModel)
    }
}
