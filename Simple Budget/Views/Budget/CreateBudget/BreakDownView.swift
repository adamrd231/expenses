//
//  BreakDownView.swift
//  Simple Budget
//
//  Created by Adam Reed on 3/21/24.
//

import SwiftUI

struct BreakDownView: View {
    @ObservedObject var vm: BudgetsViewModel
    @Binding var budget: Budget
    
    var body: some View {
        List {
            Section(header: Text("Planning"), footer: Text("Learn More")) {
                HStack {
                    Spacer()
                    VStack {
                        Text(vm.budgetModel.totalBudgetPercentage, format: .percent.precision(.fractionLength(0)))
                            .foregroundStyle(vm.budgetModel.totalBudgetPercentage > 1 ? .red : .primary)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Budget Total")
                    }
                    Spacer()
                }
                .padding(10)
                SliderView(value: $budget.needsBudgetPercentage, type: .needs)
                SliderView(value: $vm.budgetModel.wantsBudgetPercentage, type: .wants)
                SliderView(value: $vm.budgetModel.saveBudgetPercentage, type: .save)
                HStack {
                    Text("Reset budget values")
                    Spacer()
                    Button {
                        vm.budgetModel.needsBudgetPercentage = 0.5
                        vm.budgetModel.wantsBudgetPercentage = 0.3
                        vm.budgetModel.saveBudgetPercentage = 0.2
                    } label: {
                        Image(systemName: "arrow.uturn.backward.circle.fill")
                    }
                }
                .padding(10)
            }
        }
    }
}

struct BreakDownView_Previews: PreviewProvider {
    static var previews: some View {
        BreakDownView(
            vm: dev.budgetVM,
            budget: .constant(dev.budget)
        )
    }
}

