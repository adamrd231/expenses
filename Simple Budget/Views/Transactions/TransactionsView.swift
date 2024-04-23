import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var isAddingTransaction: Bool = false
    @State var categoryPickerSelection: BudgetCategory = .income
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                Picker("", selection: $transactionsVM.categoryPickerSelection) {
                    ForEach(BudgetCategory.allCases, id: \.self) { category in
                        Text(category.description)
                            .tag(category)
                    }
                }
                .pickerStyle(.segmented)
                
                ForEach(Array(zip(transactionsVM.filteredTransactions, transactionsVM.filteredTransactions.indices)), id: \.1) { transaction, index in
                    NavigationLink {
                        IndividualTransactionView(transaction: transaction)
                    } label: {
                        TransactionTableviewView(index: index + 1, transaction: transaction)
                    }
                }
                .onDelete(perform: { indexSet in
                    transactionsVM.transactions.remove(atOffsets: indexSet)
                })
                .listRowSeparator(.hidden)
            }
            
            .listStyle(.plain)
            .navigationTitle("Transactions")
            // Searchable Protocol
            .searchable(text: $transactionsVM.searchText)
            // Toolbar button item
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingTransaction.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
            // Present sheet for adding new items
            .sheet(isPresented: $isAddingTransaction, content: {
                AddTransactionView(
                    transactionsVM: transactionsVM,
                    categories: budgetsVM.budgetNames
                )
            })
        }
    }
}

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(
            transactionsVM: dev.transactionVM,
            budgetsVM: BudgetsViewModel()
        )
    }
}
