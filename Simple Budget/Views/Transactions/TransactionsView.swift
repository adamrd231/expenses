//
//  TransactionsView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/24/24.
//

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
                    Text("date")
                    Text("amount")
                }
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)

                ForEach(transactionsVM.transactions, id: \.id) { transaction in
                    HStack {
                        Text(transaction.name)
                        Spacer()
                        Text(transaction.date, style: .date)
                        Text(transaction.amount, format: .number)
                    }
                }
                .onDelete(perform: { indexSet in
                    transactionsVM.transactions.remove(atOffsets: indexSet)
                })
            }
            .listStyle(.plain)
            .navigationTitle("Transactions")
            .sheet(isPresented: $isAddingTransaction, content: {
                AddTransactionView(transactionsVM: transactionsVM, budgetsVM: budgetsVM)
                    .presentationDetents([.medium])
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

#Preview {
    TransactionsView(
        transactionsVM: TransactionsViewModel(),
        budgetsVM: BudgetsViewModel()
    )
}

