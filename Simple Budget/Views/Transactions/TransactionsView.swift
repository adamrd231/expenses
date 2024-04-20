import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var isAddingTransaction: Bool = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(zip(transactionsVM.transactions, transactionsVM.transactions.indices)), id: \.1) { transaction, index in
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
            .sheet(isPresented: $isAddingTransaction, content: {
                AddTransactionView(
                    transactionsVM: transactionsVM,
                    categories: budgetsVM.budgetNames
                )
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingTransaction.toggle()
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                }
            }
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
