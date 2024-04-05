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
            
            VStack {
                HStack {
                    Circle()
                        .frame(width: 15)
                        .foregroundStyle(Color.theme.green)
                    Spacer()
                    Text("Needs")
                }
                HStack {
                    Circle()
                        .frame(width: 15)
                        .foregroundStyle(.green)
                    Spacer()
                    Text("Wants")
                }
                HStack {
                    Circle()
                        .frame(width: 15)
                        .foregroundStyle(Color.theme.blue)
                    Spacer()
                    Text("Save")
                }
            }
            .frame(maxWidth: 100)
        }
    }
}


struct BudgetActivityView_Previews: PreviewProvider {
    static var previews: some View {
        BudgetActivityView(vm: dev.budgetVM)
    }
}
