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
            VStack(alignment: .leading) {
                HStack {
                    Text(budget.start, style: .date)
                    Text("-")
                    Text(budget.end, style: .date)
                    Spacer()
                }
                .font(.caption)
                HStack {
                    Text("Total Income")
                    Spacer()
                    Text(budget.totalBudget, format: .currency(code: "USD"))
                }
                HStack {
                    Text("Needs budget")
                    Text(budget.needsBudgetPercentage, format: .percent)
                    Spacer()
                    Text(budget.needBudgetGoal, format: .currency(code: "USD"))
                }
                HStack {
                    Text("Want budget")
                    Text(budget.wantsBudgetPercentage, format: .percent)
                    Spacer()
                    Text(budget.wantsBudgeGoal, format: .currency(code: "USD"))
                }
                HStack {
                    Text("Save budget")
                    Text(budget.saveBudgetPercentage, format: .percent)
                    Spacer()
                    Text(budget.saveBudgetGoal, format: .currency(code: "USD"))
                }
            }
        }
    }
}

struct BudgetTypeRowView: View {
    var body: some View {
        
    }
}


struct BudgetRowView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetRowView(
            budget: dev.budgetVM.budgetModel
        )
    }
}
