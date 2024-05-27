import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var isAddingTransaction: Bool = false

    var body: some View {
        NavigationStack {
            List {
                Picker("", selection: $transactionsVM.categorySelection) {
                    Text("All")
                        .tag("All")
                    ForEach(BudgetCategory.allCases, id: \.self) { category in
                        Text(category.description)
                            .tag(category.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                
                ForEach(transactionsVM.transactions, id: \.id) { transaction in
                    NavigationLink {
                        IndividualTransactionView(transaction: transaction)
                    } label: {
                        TransactionTableviewView(index: 1, transaction: transaction)
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let transaction = transactionsVM.transactions[index]
                        transactionsVM.dataManager.deleteSingle(transaction)
                    }
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
                    addTransaction: transactionsVM.addNew,
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
