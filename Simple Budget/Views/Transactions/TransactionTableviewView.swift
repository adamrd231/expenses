//
//  TransactionTableviewView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/20/24.
//

import SwiftUI

struct TransactionTableviewView: View {
    let index: Int
    let transaction: Transaction
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.lightBackground)
                .shadow(color: Color.theme.background, radius: 10)
            HStack {
                Text(index, format: .number).font(.caption)
                VStack(alignment: .leading) {
                    
                    Text(transaction.name)
                        .bold()
                    
                    HStack {
                        Text(transaction.date, style: .date)
                        Text(transaction.category.description)
                        
                    }
                    .font(.caption)
                    .foregroundStyle(Color.theme.secondaryText)
                }
                Spacer()
            
                Text(transaction.amount, format: .currency(code: "USD"))
                    .foregroundStyle(transaction.category == .income ? Color.theme.text : Color.theme.green)
            }
            .padding(10)
        }
//        .fixedSize(horizontal: false, vertical: true)
        .font(.callout)
    }
}

#Preview {
    TransactionTableviewView(index: 1, transaction: Transaction(data: Date(), amount: 100, category: .needs, type: BudgetName(name: "Stuff"), name: "Things", description: "The description for things"))
}
