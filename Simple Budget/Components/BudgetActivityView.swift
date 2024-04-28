//
//  BudgetActivityView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/5/24.
//

import SwiftUI

struct BudgetActivityView: View {
    let budget: Budget
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            Text("Overview")
                .font(.title)
                .fontWeight(.bold)
            VStack {
                GeometryReader { geo in
                    ZStack {
//                        BudgetRingView(
//                            progress: budget.needBudgetTotal / budget.needBudgetGoal,
//                            lineWidth: geo.size.width * 0.1,
//                            ringColor: Color.theme.green
//                        )
//                        .frame(width: geo.size.width)
//                        
//                        BudgetRingView(
//                            progress: budget.wantsBudgetTotal / budget.wantsBudgeGoal,
//                            lineWidth: geo.size.width * 0.1,
//                            ringColor: .green
//                        )
//                        .frame(width: geo.size.width - (geo.size.width * 0.25))
//        
//                        BudgetRingView(
//                            progress: budget.saveBudgetTotal / budget.saveBudgetGoal,
//                            lineWidth: geo.size.width * 0.1,
//                            ringColor: Color.theme.blue
//                        )
//                        .frame(width: geo.size.width - (geo.size.width * 0.5))
        
                    }
                    .frame(width: geo.size.width)
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
}

struct BudgetActivityView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetActivityView(budget: dev.budget)
    }
}

