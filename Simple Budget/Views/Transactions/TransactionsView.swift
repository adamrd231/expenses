import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var isAddingTransaction: Bool = false

    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Text("name")
                    Spacer()
                    Text("category")
                    Spacer()
                    Text("Type")
                    Spacer()
                    Text("amount")
                }
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)

                ForEach(Array(zip(transactionsVM.transactions, transactionsVM.transactions.indices)), id: \.1) { transaction, index in
                    NavigationLink {
                        IndividualTransactionView(transaction: transaction)
                    } label: {
                        HStack {
                            Text(index + 1, format: .number).font(.caption)
                            Text(transaction.name)
                            Spacer()
                            Text(transaction.category.description)
                            Spacer()
                            Text(transaction.type.name)
                            Spacer()
                            Text(transaction.amount, format: .currency(code: "USD"))
                        }
                        .font(.callout)
                    }

                    
                }
                .onDelete(perform: { indexSet in
                    transactionsVM.transactions.remove(atOffsets: indexSet)
                })
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
