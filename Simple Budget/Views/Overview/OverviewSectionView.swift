//
//  OverviewSectionView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/25/24.
//

import SwiftUI

struct OverviewSectionView: View {
    let title: String
    let type: BudgetCategory
    let totalSpend: Double
    let totalFromBudget: Double
    let items: [BudgetItem]
    let transactions: [Transaction]
    
    func getPercentageCompletedForBudgetItem(totalAmount: Double, name: String) -> Double {
        let filteredTransactions = transactions.filter({ $0.name == name })
        let totalSpent = filteredTransactions.map({ $0.amount }).reduce(0,+)
        return totalSpent / totalAmount
    }
    
    func getTotalAmountSpentOnBudgetItem(name: String) -> Double {
        let filteredTransactions = transactions.filter({ $0.name == name })
        return filteredTransactions.map({$0.amount}).reduce(0, +)
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                OverviewCategoryView(type: type, totalSpend: totalSpend, totalFromBudget: totalFromBudget, usingBorder: false)
                ScrollView {
                    ForEach(items, id: \.id) { item in
                        HStack {
                            VStack {
                                Text(item.name)

                                if let unwrappedDate = item.due {
                                    Text(unwrappedDate, format: .number)

                                }
                                Text(item.amount, format: .number)
   
                            }
                            VStack {
                                Text(getPercentageCompletedForBudgetItem(totalAmount: item.amount, name: item.name), format: .number)

                                Text(getTotalAmountSpentOnBudgetItem(name: item.name), format: .number)
  
                            }
                    
                        }
                      
                       
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(title)
        }
    }
}

#Preview {
    OverviewSectionView(
        title: "Needs",
        type: .needs,
        totalSpend: 1000,
        totalFromBudget: 2000,
        items: [
            BudgetItem(type: .needs, name: "Rent", amount: 900)
        ],
        transactions: [
            Transaction(data: Date(), amount: 100, category: .needs, type: TransactionCategory(name: "Upwork"), name: "Rent", description: "Paid rent")
        ]
    )
}
