//
//  BudgetActivityView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/5/24.
//

import SwiftUI

struct BudgetActivityView: View {
    let budget: Budget
    
    func getRingColor(_ index: Int) -> Color {
        if index == 0 {
            return Color.theme.green
        }
        if index == 1 {
            return Color.theme.gray
        }
        if index == 2 {
            return Color.theme.blue
        }
        return Color.theme.gray
    }
    func getRingSize(_ index: Int, _ geoSize: Double) -> Double {
        if index == 0 {
            return geoSize
        }
        if index == 1 {
            return geoSize * 0.5
        }
        if index == 2 {
            return geoSize * 0.25
        }
        return geoSize
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {

            GeometryReader { geo in
                ZStack(alignment: .center) {
                    ForEach(Array(zip(budget.budgetItems, budget.budgetItems.indices)), id: \.1) { item, index in
                        BudgetRingView(
                            progress: item.totalSpend / item.budgetPercentage * budget.incomeItems.map({$0.amount}).reduce(0,+),
                            lineWidth: geo.size.width * 0.1,
                            ringColor: getRingColor(index)
                        )
                        .frame(width: getRingSize(index, geo.size.width))
                    }
                }
            }
        }
        .frame(width: 250, height: 250, alignment: .center)
//            BottomRowView(
//                category: "Needs",
//                percent: (1 - (budget.needBudgetTotal / budget.needBudgetGoal)),
//                color: Color.theme.green
//            )
//            BottomRowView(
//                category: "Wants",
//                percent: (1 - (budget.wantsBudgetTotal / budget.wantsBudgeGoal)),
//                color: .green
//            )
//            BottomRowView(
//                category: "Save",
//                percent: (1 - (budget.saveBudgetTotal / budget.saveBudgetGoal)),
//                color: Color.theme.blue
//            )
    }
}

struct BudgetActivityView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetActivityView(budget: dev.budget)
    }
}

