//
//  BudgetActivityView.swift
//  Simple Budget
//
//  Created by Adam Reed on 4/5/24.
//

import SwiftUI

struct BudgetActivityView: View {
    @ObservedObject var vm: BudgetsViewModel
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Overview")
                .font(.title)
                .fontWeight(.bold)
            VStack {
                GeometryReader { geo in
                    ZStack {
                        BudgetRingView(
                            progress: vm.budgetModel.needBudgetTotal / vm.budgetModel.needBudgetGoal,
                            lineWidth: geo.size.width * 0.1,
                            ringColor: Color.theme.green
                        )
                        .frame(width: geo.size.width)
                        
                        BudgetRingView(
                            progress: vm.budgetModel.wantsBudgetTotal / vm.budgetModel.wantsBudgeGoal,
                            lineWidth: geo.size.width * 0.1,
                            ringColor: .green
                        )
                        .frame(width: geo.size.width - (geo.size.width * 0.25))
        
                        BudgetRingView(
                            progress: vm.budgetModel.saveBudgetTotal / vm.budgetModel.saveBudgetGoal,
                            lineWidth: geo.size.width * 0.1,
                            ringColor: Color.theme.blue
                        )
                        .frame(width: geo.size.width - (geo.size.width * 0.5))
        
                    }
                    .frame(width: geo.size.width)
                }
            }
            .frame(width: 250, height: 250, alignment: .center)
            BottomRowView(
                category: "Needs",
                percent: (1 - (vm.budgetModel.needBudgetTotal / vm.budgetModel.needBudgetGoal))
            )
            BottomRowView(
                category: "Wants",
                percent: (1 - (vm.budgetModel.wantsBudgetTotal / vm.budgetModel.wantsBudgeGoal))
            )
        }
    }
}

struct BudgetActivityView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetActivityView(vm: dev.budgetVM)
    }
}

