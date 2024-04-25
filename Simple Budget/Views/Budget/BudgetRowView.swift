//
//  BudgetRowView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/20/24.
//

import SwiftUI

struct BudgetRowView: View {
    let budget: Budget
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(Color.theme.lightBackground)
                .shadow(color: Color.theme.background, radius: 10)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text(budget.start, style: .date)
                    Text("-")
                    Text(budget.end, style: .date)
                    Spacer()
                }
                .font(.caption)

                BudgetTypeRowView(type: .income, percentage: budget.totalBudgetPercentage, goal: budget.totalBudget)
                BudgetTypeRowView(type: .needs, percentage: budget.needsBudgetPercentage, goal: budget.needBudgetGoal)
                BudgetTypeRowView(type: .wants, percentage: budget.wantsBudgetPercentage, goal: budget.wantsBudgeGoal)
                BudgetTypeRowView(type: .save, percentage: budget.saveBudgetPercentage, goal: budget.saveBudgetGoal)
            }
            .padding()
        }
    }
}

struct BudgetTypeRowView: View {
    let type: BudgetCategory
    let percentage: Double
    let goal: Double
    var body: some View {
        HStack {
            if type == .income {
                Text("Income")
                    .bold()
            } else {
                HStack(spacing: 5) {
                    Text(type.rawValue)
                    Text(percentage, format: .percent)
                }
                .font(.subheadline)
                
            }
            Spacer()
            Text(goal, format: .currency(code: "USD"))
                .font(.subheadline)
                
        }
        .font(.callout)
        
    }
}


struct BudgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetRowView(
            budget: dev.budgetVM.budgetModel
        )
    }
}
