import SwiftUI

struct OverviewView: View {
    @ObservedObject var budgetVM: BudgetsViewModel
    @ObservedObject var transactionVM: TransactionsViewModel
    @Binding var selectedTab: Int
    @State var isShowingDetailView: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 25) {
                    ForEach(BudgetCategory.allCases, id: \.rawValue) { category in
                        CustomProgressBar(
                            startDate: Date(),
                            endDate: Date().addingTimeInterval(1000),
                            currentSpend: transactionVM.getActualTotalFromTransactions(type: category),
                            totalBudget:  budgetVM.getExpectedTotalFromBudgets(type: category),
                            type: category
                        )
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle("Overview")
            if budgetVM.budgets.isEmpty {
                Button {
                    selectedTab = 1
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.theme.green)
                        HStack {
                            Image(systemName: "plus.circle")
                            Text("Create budget")
                                .bold()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundStyle(.white)
                    }
                    .fixedSize(horizontal: false, vertical: true)
                }
                .padding()
            }
        }
    }
}

#Preview {
    OverviewView(
        budgetVM: BudgetsViewModel(),
        transactionVM: TransactionsViewModel(),
        selectedTab: .constant(0)
    )
}

/**
 List of overview with its cells
 */
extension OverviewView {
    /**
     OverView list
     */
//    func OverviewList() -> some View {
//        LazyVStack(spacing: Constant.setSpace._20Padding) {
//            OverviewCell(
//                for: .Income,
//                startValue: self.overviewVM.dataModel?.incomeReceived ?? 0,
//                endValue: self.overviewVM.dataModel?.incomeExpected ?? 0
//            ) {
////                self.delegateHost.delegate?.sectionTapped(.Income)
//            }
//            OverviewCell(
//                for: .Needs,
//                startValue: self.overviewVM.dataModel?.needsLeft ?? 0,
//                endValue: self.overviewVM.dataModel?.needsSpent ?? 0
//            ) {
////                self.delegateHost.delegate?.sectionTapped(.Needs)
//            }
//
//            OverviewCell(
//                for: .Wants,
//                startValue: self.overviewVM.dataModel?.wantsLeft ?? 0,
//                endValue: self.overviewVM.dataModel?.wantsSpent ?? 0
//            ) {
////                self.delegateHost.delegate?.sectionTapped(.Wants)
//            }
//
//
//            OverviewCell(
//                for: .Save,
//                startValue: self.overviewVM.dataModel?.saveLeft ?? 0,
//                endValue: self.overviewVM.dataModel?.saveSaved ?? 0
//            ) {
////                self.delegateHost.delegate?.sectionTapped(.Save)
//            }
//        }
//    }

    /**
     Cell for overview list
     */
    
}


/**
 Four types of cell for the overview screen
 **/
extension OverviewView {
    enum CellType: String {
        case Income                     = "Income"
        case Needs                      = "Needs"
        case Wants                      = "Wants"
        case Save                       = "Save"
    }
}
