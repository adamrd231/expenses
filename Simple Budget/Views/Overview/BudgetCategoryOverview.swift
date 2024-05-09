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
    let transactionItems: [Transaction]
    
    func getBudgetItemNameTotal(itemName: BudgetName) -> Double {
        let budgetItemsByName = transactionItems.filter({ $0.type == itemName })
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
                        Text(item.name.name)
                        Spacer()
                        Text(getBudgetItemNameTotal(itemName: item.name), format: .currency(code: "USD"))
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
                            HStack(alignment: .center) {
                                Text(transaction.type.name)
                                Text("(\(transaction.category.description))")
                                    .font(.caption2)
                                    .fontWeight(.light)
                            }
                            Text(transaction.date, style: .date)
                                .font(.caption2)
                                .foregroundStyle(Color.theme.secondaryText)
                        }
                       
                        Spacer()
                        Text(transaction.amount, format: .currency(code: "USD"))
                            .foregroundStyle(category == .income ? Color.theme.green : Color.theme.red)
                            .font(.subheadline)
                    }
                    .font(.caption)
                }
            }
            
            
        }
        .padding()
        .navigationTitle(category.description)

    }
   
}

#Preview {
    NavigationStack {
        BudgetCategoryOverview(
            category: .income,
            budgetTotal: 3000,
            budgetItems: [
                BudgetItem(name: BudgetName(name: "App work"), amount: 2000),
                BudgetItem(name: BudgetName(name: "Lawn mowing"), amount: 1000)
            ],
            transactionTotal: 2000,
            transactionItems: [
                Transaction(data: Date(), amount: 100, category: .income, type: BudgetName(name: "Reeds landing lawn"), description: ""),
                Transaction(data: Date(), amount: 100, category: .needs, type: BudgetName(name: "Reeds landing lawn"), description: "")
            ]
        )
    }
    
}
