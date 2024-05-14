import SwiftUI

struct OverviewView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @ObservedObject var transactionVM: TransactionsViewModel
    @Binding var selectedTab: Int
    @State var isShowingDetailView: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Section("Dashboard") {
                    ForEach(BudgetCategory.allCases, id: \.rawValue) { category in
                        NavigationLink {
//                            BudgetCategoryOverview(
//                                category: category,
//                                budgetTotal: budgetVM.getExpectedTotalFromBudgets(type: category),
//                                budgetItems: budgetVM.getBudgetItems(category: category),
//                                transactionTotal: transactionVM.getActualTotalFromTransactions(type: category),
//                                transactionItems: transactionVM.transactions.filter({ $0.category == category.description })
//                            )
                            
                        } label: {
                            CustomProgressBar(
                                currentSpend: transactionVM.getActualTotalFromTransactions(type: category),
                                totalBudget:  budgetVM.getExpectedTotalFromBudgets(type: category),
                                type: category
                            )
                            .padding(.vertical)
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
