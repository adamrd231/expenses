//
//  BudgetCategoryOverview.swift
//  Simple Budget
//
//  Created by Adam Reed on 5/8/24.
//

import SwiftUI

struct BudgetCategoryOverview: View {
    let category: BudgetCategory
    let budgetTotal: Double
    let budgetItems: [BudgetItem]
    let transactionTotal: Double
    let transactionItems: [TransactionEntity]
    
    func getBudgetItemNameTotal(itemName: BudgetItemType) -> Double {
        let budgetItemsByName = transactionItems.filter({ $0.type == itemName.name })
        return budgetItemsByName.map({ $0.amount }).reduce(0, +)
    }
    
    var body: some View {
        List {
            Section("Status") {
                CustomProgressBar(currentSpend: transactionTotal, totalBudget: budgetTotal, type: category)
            }
            
            Section("Types") {
                ForEach(budgetItems, id: \.id) { item in
                    HStack {
                        Text(item.type.name)
                        Spacer()
                        Text(getBudgetItemNameTotal(itemName: item.type), format: .currency(code: "USD"))
                        Text("/")
                        Text(item.amount, format: .currency(code: "USD"))
                    }
                    .font(.caption)
                }
            }
            
            Section("Entries") {
                ForEach(transactionItems, id: \.id) { transaction in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(transaction.type ?? "")
                            Text(transaction.date ?? Date(), style: .date)
                                .font(.caption2)
                                .foregroundStyle(Color.theme.secondaryText)
                        }
                        Spacer()
                        Text(transaction.amount, format: .currency(code: "USD"))
                            .font(.subheadline)
                    }
                    .font(.caption)
                }
            }
        }
        .navigationTitle(category.description)
    }
}

#Preview {
    NavigationStack {
        BudgetCategoryOverview(
            category: .income,
            budgetTotal: 3000,
            budgetItems: [
                BudgetItem(name: BudgetItemType(name: "App work"), amount: 2000),
                BudgetItem(name: BudgetItemType(name: "Lawn mowing"), amount: 1000)
            ],
            transactionTotal: 2000,
            transactionItems: [
                TransactionEntity()
            ]
        )
    }
    
}
