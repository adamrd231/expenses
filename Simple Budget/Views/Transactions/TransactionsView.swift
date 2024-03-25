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
                ForEach(transactionsVM.transactions, id: \.id) { transaction in
                    VStack {
                        HStack {
                            Text(transaction.date, style: .date)
                                .modifier(BorderModifier())
                            Text(transaction.amount, format: .number)
                                .modifier(BorderModifier())
                        }
                        HStack {
                            Text(transaction.type.name)
                                .modifier(BorderModifier())
                            Text(transaction.name)
                                .modifier(BorderModifier())
                        }
                        Text(transaction.description)
                            .modifier(BorderModifier())
                    }
                }
                .onDelete(perform: { indexSet in
                    transactionsVM.transactions.remove(atOffsets: indexSet)
                })

               
            }
            .listStyle(.plain)
            PlusButton(action: { isAddingTransaction.toggle() })
            .navigationTitle("Transactions")
            .sheet(isPresented: $isAddingTransaction, content: {
                AddTransactionView(transactionsVM: transactionsVM, budgetsVM: budgetsVM)
                    .presentationDetents([.medium])
            })
        }
    }
}

#Preview {
    TransactionsView(
        transactionsVM: TransactionsViewModel(),
        budgetsVM: BudgetsViewModel()
    )
}

