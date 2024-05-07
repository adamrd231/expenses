import SwiftUI

struct OverviewView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @ObservedObject var transactionVM: TransactionsViewModel
    @Binding var selectedTab: Int
    @State var isShowingDetailView: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section("Budget Info") {
                    HStack {
                        Text("Budgets created")
                        Spacer()
                        Text(budgetVM.budgets.count, format: .number)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Starting date")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(Color.theme.secondaryText)
                            let sortedBudgets = budgetVM.budgets.sorted(by: { $0.start > $1.start})
                            Text(sortedBudgets.first?.start ?? Date(), style: .date)
                                .font(.callout)
                        }
                        Spacer()
                        VStack(alignment: .leading) {
                            Text("Ending date")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(Color.theme.secondaryText)
                            let sortedBudgets = budgetVM.budgets.sorted(by: { $0.end > $1.end})
                            Text(sortedBudgets.first?.start ?? Date(), style: .date)
                                .font(.callout)
                        }
                    }
                    .padding(.top, 5)
                }
                Section("Overview") {
                    VStack(spacing: 25) {
                        ForEach(BudgetCategory.allCases, id: \.rawValue) { category in
                            CustomProgressBar(
                                currentSpend: transactionVM.getActualTotalFromTransactions(type: category),
                                totalBudget:  budgetVM.getExpectedTotalFromBudgets(type: category),
                                type: category
                            )
                        }
                    }
                }
            }
            
            .navigationTitle("Overview")
        }
    }
}

struct OverviewView_Previews: PreviewProvider {
    static var previews: some View {
        OverviewView(
            budgetVM: dev.budgetVM,
            transactionVM: TransactionsViewModel(),
            selectedTab: .constant(0)
        )
    }
}
