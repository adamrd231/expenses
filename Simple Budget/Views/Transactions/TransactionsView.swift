import SwiftUI

struct TransactionsView: View {
    @ObservedObject var transactionsVM: TransactionsViewModel
    @ObservedObject var budgetsVM: BudgetsViewModel
    @State var isAddingTransaction: Bool = false
    @State var categoryPickerSelection: BudgetCategory = .income
    @State var searchText: String = ""

    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(Color.theme.lightBackground)
                    .shadow(color: Color.theme.background, radius: 10)
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search Transactions", text: $searchText)
                }
                .padding(10)
                Picker("", selection: <#T##Binding<Hashable>#>, content: <#T##() -> View#>)
                Picker(BudgetCategory.allCases, id: \.self) { category in
                    Text(category.description)
                        .tag(category)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .padding(.horizontal)
            
            
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
