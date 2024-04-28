//
//  BudgetOverviewRowView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/25/24.
//

import SwiftUI

struct BudgetOverviewRowView: View {
    let type: BudgetCategory
    let budgetGoal: Double
    let budgetItemTotal: Double
    var body: some View {
        GridRow {
            Text(type.description)
                .bold()
    
            VStack {
                Text("Budget")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.secondaryText)
                    .textCase(.uppercase)
                Text(budgetGoal, format: .currency(code: "USD"))
                    .font(.caption)
            }
            VStack {
                Text("Allocated")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.secondaryText)
                    .textCase(.uppercase)
                Text(budgetItemTotal, format: .currency(code: "USD"))
                    .font(.caption)
            }
            VStack {
                Text("left")
                    .font(.caption2)
                    .fontWeight(.heavy)
                    .foregroundStyle(Color.theme.secondaryText)
                    .textCase(.uppercase)
                Text((budgetItemTotal / budgetGoal), format: .percent.precision(.fractionLength(0)))
                    .font(.caption)
                    .foregroundStyle((budgetItemTotal / budgetGoal) > 0 ? Color.theme.green : Color.theme.red)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    Grid {
        BudgetOverviewRowView(type: .income, budgetGoal: 100, budgetItemTotal: 10)
    }
}
