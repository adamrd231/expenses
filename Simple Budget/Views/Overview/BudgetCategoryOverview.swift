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
    
    var body: some View {
        VStack {
            HStack {
                HStack(spacing: 5) {
                    Text(category.description)
                    Text("Budget")
                }
         
                
                Spacer()
                Text(budgetTotal, format: .currency(code: "USD"))
            }
            .font(.title2)
            
            ForEach(budgetItems, id: \.id) { item in
                HStack {
                    Text(item.name.name)
                    Spacer()
                    Text(item.amount, format: .currency(code: "USD"))
                }
            }
            
            Divider()
            
            HStack {
                HStack(spacing: 5) {
                    Text(category.description)
                    Text("Transactions")
                }
         
                
                Spacer()
                Text(transactionTotal, format: .currency(code: "USD"))
            }
            .font(.title2)
            
            ForEach(transactionItems, id: \.id) { transaction in
                HStack {
                    HStack {
                        Text(transaction.category.description)
                        Text("(\(transaction.type.name))")
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                   
                    Spacer()
                    Text(transaction.amount, format: .currency(code: "USD"))
                }
            }
            
//            HStack {
//                Text(category.description)
//                
//                Spacer()
//                Text(transactionTotal, format: .currency(code: "USD"))
//            }
        }
        .padding()
    }
}

#Preview {
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
