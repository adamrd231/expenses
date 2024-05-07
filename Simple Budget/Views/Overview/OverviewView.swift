import SwiftUI

struct OverviewView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @ObservedObject var transactionVM: TransactionsViewModel
    @Binding var selectedTab: Int
    @State var isShowingDetailView: Bool = false

    var body: some View {
        NavigationStack {
            List {
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
